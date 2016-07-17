# Docker Based Web Application Runtime

## Installing

### Requirements:

You should have these softeware installed on you host:

- Vagrant (https://www.vagrantup.com/downloads.html)
- Ansible (https://docs.ansible.com/ansible/intro_installation.html)

### Config:

- Edit `Vagrantfile`, change mapped host port and number of web server instances.
- Edit `group_vars/all`, change proxy settings if you need it for better internet access, or comment out if you dont need it.
- Edit `roles/common/files/sources.list`, for a faster apt-get source server.

### Startup:

Execute `vagrant up` in the root dir of this project.

This will spawn number of VMs on your host to form a docker cluster, you can later deploy code or scale number of web instances.

## Code Deployment

Execute `vagrant ssh -c '/vagrant/bin/deploy.sh'` to build and commit new version of code in `webapp` dir, after the process, you will be able to access it from [http://127.0.0.1:8080] (or any other port defined in Vagrantfile)

## Scaling

Execute `vagrant ssh -c '/vagrant/bin/scale.sh <number of instance>'` to change number of instances of application.

## Notes

- This is for demostration perpose only and did not have any security related setups, DO NOT use it in production environment directly.
- The example application is written in CoffeeScript and uses Mongodb as database

# How things works

The basic idea is simple: spawn docker instances with docker-compose and then generate nginx config and reload it. But in such case, a little downtime would be expected when scaling down the application, since configure generation is not realtime.

Docker daemon was set to form a cluster for overlay networks, this will allow swarm to link instances among multiple hosts, not the downside would be the performance of VXLAN networks, but since this is only a demo evnvironment, this is OK

Swarm is used to manage instances, swarm agent will register them self into etcd server and swarm manager can be notified for changes.

Both etcd and consul is used for service discovery, but in fact, they do the same work. However I encountered some trouble to connect swarm with consul and docker daemon to etcd, so i used both of them.

During I writing this, I found a interesting tool called interlock (https://github.com/ehazlett/interlock) which can be used for managing the load balancers. so I switch to this and found it worked very well. 



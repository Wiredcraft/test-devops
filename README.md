# Docker Based WebAPP Runtime

## Installing

### Requirements:

You should have these softeware installed on you host:

- [Vagrant https://www.vagrantup.com/downloads.html]
- [Ansible https://docs.ansible.com/ansible/intro_installation.html]

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

Execure `vagrant ssh -c '/vagrant/bin/scale.sh <number of instance>'` to change number of instances of application.

## Notes

- This is for demostration perpose only and did not have any security related setups, DO NOT use it in production environment directly.


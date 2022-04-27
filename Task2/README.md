# Description
> Ansible playbook initializes the server and installs some runtime environments

# Roles
### initialization
* Modify time zone and time
* Upgrade and install basic software
* Create  directory
* Modify the hostname
* Modify kernel parameters
* Set environment variables
* Modify the login welcome information
* configure ssh
### init_disk
Initialize data disk: single partition, ext4.
### init_user
Create user, set key login and set sudo nopass.

### install_docker
Get the latest version of docker installation from github.
### install_mysql
Install mysql 8.0 .

### install_nginx
Use the yum to install the latest version of nginx.

### deploy_server
Use docker to deploy an api-server.

### backup_mysql
Setup a cron job for regular full Mysql/Mariadb database dumps.

# Get Started
All credential and password is protected by ansible-vault. 
```bash
ansible-vault encrypt password.yml
```
to run any playbook:
1. Add or remove the roles ,then modify the hosts to the server you need to scheduleand in Task2/main.yml
```yml
- hosts: api-server
  become: false
  become_method: sudo
  become_user: root
  roles:
     - init_user
     - init_disk
     - initialization
     - install_docker
     - install_mysql
     - deploy_server
     - install_nginx
     - backup_mysql
```
2. Run it!
```bash
ansible-playbook main.yml
```
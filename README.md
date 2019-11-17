# Wiredcraft DevOps - Static website generator and build flow (homework)

## Table of contents
- [Background](#Background)
- [System overview](#System-overview)
- [Repository structure](#Repository-structure)
- [Local environment requirements](#Local-environment-requirements)
- [Setting-up development environment](#Setting-up-development-environment)

## Background

The original homework task description can be found [here](https://github.com/Wiredcraft/test-devops/blob/04e752448bf9d03bf515620e65b4b95cf07b137c/README.md).


## System overview

In this project, I use a local Vagrant box for `dev` and `stage` environment. The developer local environment is UNIX based OS.

Once you follow steps at [Setting-up development environment](#Setting-up-development-environment) part you will end up with running locally Vagrant Centos7 box with following:

- Development and staging websites ([dev](http://dev.devopstest.com/) an [stage](http://stage.devopstest.com/))  
- Crontab jobs:
    - create new dev version on website every 15 minutes and push to Git
    - create new stage version on website every hour and push to Git
    - check for updates on Git every 3 minutes and deploy either dev or stage websites if needed 

### Vagrant box folder structure

- DEV website files are at `/var/www/dev` where we keep history of development versions and have two links: `latest` and `previous`

- DEV website files are at `/var/www/stage` where we keep history of stage versions and have two links: `latest` and `previous`

- Crontab to automatically make dev/stage changes working with project at `home/vagrant/test-devops/push`

- Crontab to automatically check and deploy dev/stage changes working with project at `home/vagrant/test-devops/pull`



## Repository structure

```
.
├── Makefile    <--- Collection of useful commands 
├── ansible     <--- Ansible playbooks for server spawn (ment to be run from local against Vagrant box)
├── scripts     <--- Crontab scripts (meant to be run on the box)
├── vagrant_box <--- Vagrant configs 
└── website     <--- HUGO website
```
To learn about all possible Makefile commands please run `make`:
```
$ make

Usage:
  make <target>

Vagrant
  box_create       Create vagrant box and add it's ssh key and configuration to ~/.ssh/
...
```

## Setting-up development environment

Please follow steps bellow to set-up local environment.

### Local environment requirements

- Virtual Box 5.2.x
- Vagrant 2.2.x
- Python 2.7.x as default on your local
- Ansible 
- **GNU grep**
- Perl 5.x

### Local environment requirements setup:

#### Virtual Box, Vagrant, Python 

Depending on your OS follow official documentation (google for it) and best practices to install this software

#### Installing ansible

- Make sure you have python and pip for version 2.7.x:
```sh
$ python --version
Python 2.7.12
$ pip --version
pip 8.1.1 from /usr/lib/python2.7/dist-packages (python 2.7)
```
- Install python core dev tools
```sh
$ pip install --user -i https://pypi.tuna.tsinghua.edu.cn/simple/ setuptools pip virtualenv

# check it
$ which virtualenv
/home/ilya/.local/bin/virtualenv
```
- Create virtual environment for our project:
```
# navigate to our project repo
$cd /home/ilya/dev/test-devops

# crete python environemnt
$ virtualenv --system-site-packages --no-download .venv
```
- Install Ansible inside virtual environment
```sh
# activate venv
$ source .venv/bin/activate
(.venv) $ which python
/home/ilya/test-devops/.venv/bin/python

# install Ansible
(.venv) $ pip install --user -i https://pypi.tuna.tsinghua.edu.cn/simple/ ansible==2.9.0
```

### Initial Vagrant box setup 

- First, we need to spawn a vagrant box with following commands:

```sh
# create a vagrant box
$ make box_create

# add following lines to `/etc/hosts` file using text editor of your choice
192.168.33.10 devopstest.com
192.168.33.10 dev.devopstest.com
192.168.33.10 stage.devopstest.com

# test ssh settings by connecting to the box
$ ssh devopstest.com
```

- Next, we need to provision the vagrant box with Ansible playbook (takes sometime depending on your internet network)
```sh
$ make box_init
```

- Check the box setup

By now you must have set-up the local environment. To check development and stage websites please click on links: [dev](http://dev.devopstest.com/) or [stage](http://stage.devopstest.com/) (NOTE: make sure your system network proxy has an exception for 192.168.* or simply turn proxy off)

- Configure **make changes** and **deploy changes** crontabs
```
$ make box_init_crontabs
```
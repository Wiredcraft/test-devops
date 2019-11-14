# Wiredcraft DevOps - Static website generator and build flow (homework)

## Background

The original homework task description can be found [here](https://github.com/Wiredcraft/test-devops/blob/04e752448bf9d03bf515620e65b4b95cf07b137c/README.md).


## System design

In this project, I use a local Vagrant box for `dev` and `stage` environment. The developer local environment is UNIX based OS.

## For development

### Local environemnt requirements:

- Virtual Box 5.2.x
- Vagrant 2.2.x
- Python 2.7.x as default on your local
- Ansible 

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
/mnt/d/02_github/test-devops/.venv/bin/python

# install Ansible
(.venv) $ pip install --user -i https://pypi.tuna.tsinghua.edu.cn/simple/ ansible==2.9.0
```

### Initial Vagrant box setup 

- First, we need to spawn a vagrant box with following commands:

```sh
# start the vagrant box
$ cd vagrant_box
$ vagrant up

#copy vagrant box ssh key to your local user .ssh
$ cp .vagrant/machines/default/virtualbox/private_key ~/.ssh/vagrant_key_201912

$ chmod 600 ~/.ssh/vagrant_key_201912

# add following lines to `/etc/hosts` file using text editor of your choice
192.168.33.10 devopstest.com
192.168.33.10 dev.devopstest.com
192.168.33.10 stage.devopstest.com

$ cat <<EOT>> ~/.ssh/config
Host devopstest.com
     HostName devopstest.com
     User vagrant
     Port 22
     StrictHostKeyChecking no
     PasswordAuthentication no
     IdentityFile ~/.ssh/vagrant_key_201912
     UserKnownHostsFile /dev/null
EOT

# test ssh settings by connecting to the box
$ ssh devopstest.com
```

- Next, we need to provision the vagrant box with Ansible playbook (make sure are inside the python virtual environment we created before)
```sh
TODO
```

# Ansible Role: initialization
An Ansible Role that init system on Linux.

* Modify time zone and time
* Upgrade and install basic software
* Create  directory
* Modify the hostname
* Modify kernel parameters
* Set environment variables
* Modify the login welcome information
* configure ssh

#  Role Variables
default values (see `defaults/main.yml`)
# Example Playbook
```yml
- hosts: all
  roles:
    - initialization
```



# Ansible Role: deploy api
> An ansible role to deploy a api server.

# Installation
```bash
ansible-galaxy collection install community.docker 
```
#  Role Variables
encrypt values(`default/main.yml`)
```yml
docker_registry: registry_url
docker_registry_username: uname
docker_registry_password: passwd
docker_image: image

db_url:   db_url
db_username: db_uname
db_password: db_passwd
```
# Example Playbook
```yml
- hosts: all
  roles:
    - deploy_server
```



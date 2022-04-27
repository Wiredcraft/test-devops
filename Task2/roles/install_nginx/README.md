# Ansible Role: install nginx
> An ansible role to install nginx in centos 7 .


#  Role Variables

```yml
# external url
external_url: your_domain

# log path
access_log_path: /data/logs/nginx/api.access.log
error_log_path: /data/logs/nginx/api.error.log

# api_url
api_url: http://127.0.0.1:3000
```
# Example Playbook
```yml
- hosts: all
  roles:
    - install_nginx
```



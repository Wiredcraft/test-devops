# Ansible Role: backup_mysql
Setup a cron job for regular full Mysql/Mariadb database dumps.
Assumes root has password-less access to all databases.

#  Role Variables
default values (see `defaults/main.yml`)

# Example Playbook
```yml
- hosts: all
  roles:
    - backup_mysql
```



# Ansible Role: Mysql
An Ansible Role that installs Mysql on Centos7.
#  Role Variables
default values (see `defaults/main.yml`)
encrypt values(`vars/vault.yml`)
```yml
# encrypt values
mysql_users:
     - name: username
       pass: pass
       priv: "*.*:ALL"
mysql_db:
     - name: dbname
       replicate: yes
     - name: bar
       replicate: no
```
# Example Playbook
```yml
- hosts: all
  roles:
    - install_mysql
```



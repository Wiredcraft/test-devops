# test2

### run
```shell
# some user have sudo
ansible-playbook -i inventory -u user -b init-playbook.yml
```

### node-init
* stop swap
* stop firewalld
* install docker and mosh
* create a user and add this user to docker user group

Swap will reduces server's performance.It should be stopped.


The server in the intranet environment does not need a firewall，so I stop firewalld.

Mosh is used to ensure that maintainer can login the server without sshd

### database
* run a database container
* create a cronjob to backup database

Percona Xtrabackup is a open-source, free MySQL hot backup software.

### api-server
Run a API service container.

### web-server
Run a nginx web server container.

### reload-sshd
This sshd_config is just a demo file, it was copied from somewhere.

Reload sshd.service is a very dangerous operation, so it was put last. We must start a mosh service before reloading sshd in case sshd server reload fails.
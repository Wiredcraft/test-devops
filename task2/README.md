## Install Docker Registry using Ansible Playbook

**Note:** This Ansible Playbook is written for Ubuntu servers.

### How to Install It?

There 3 files in this directory.

- `hosts` contains servers information. Both IP and domain name can
  be used.

- `ansible.cfg` is used to tell the command line tools `ansible` and `ansible-playbook` to read the `hosts` for servers information.

- `setup_docker_registry.yaml` is the Ansible Playbook file.

To install Docker Registry on server, first we need to
replace `example.com:22` with the real server in `hosts` file.

We then generate ssh key using command `ssh-keygen` on our local
machine, and copy the generated public key to remote server.

Use command `ansible all -m ping` to check if everything is OK.
If so, then we can execute `ansible-playbook setup_docker_registry.yaml`
and ansible will install and run both Docker Engine and Docker Registry.

### Test an Insecure Registry

The Docker Registry listens on port 5000. When we run command
like `docker push example.com:5000/my-busybox` it will fail, because `docker`
communicate with registry server using HTTPS.

To fix that, we need to configure our local Docker Engine, add
the following configuration and restart the Docker Engine.

```json
  "insecure-registries": [
    "example.com:5000"
  ],
```

For test purpose I think this will be OK, but in real production
environment, we may need to setup TLS certificate to support HTTPS.

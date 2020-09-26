# Wiredcraft DevOps - Interview Task

## Requirements

- Terraform
- Ansible
- Hugo
- Makefile

## Architecture Design

1. Create a server with terraform, and install required package by ansible.
2. Using Github Action Schedule feature to create new post and new tag periodically.
3. Using Github Action to deploy latest commit and tag.

## Getting Started

### Prepare

#### Set digtalocean token

```sh
export DO_TOKEN=bbxxxxxx
```

#### Create ssh key and add them into digtalocean

```sh
# the key files will be saved in current dir
make create-ssh-key
```

### Init environment

```sh
make init
```

### Create server

```sh
make create-server
```

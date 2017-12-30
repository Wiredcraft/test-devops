# Wiredcraft DevOps - Static website generator and build flow

# Preamble

There are some repos:

- [test-devops-site](https://github.com/kaleocheng/test-devops-site): Site base on Hugo.
- [test-devops-neo](https://github.com/kaleocheng/test-devops-neo): The Template for our site.
- [test-devops-cli](https://github.com/kaleocheng/test-devops-cli): The script to create a post, commit and push.
- [test-devops-ansible](https://github.com/kaleocheng/test-devops-ansible): The ansible playbook to deploy server and serve the site.

## Technical stack

- Use Hugo as the static site generator
- Use Shell and Golang([why?](https://github.com/kaleocheng/test-devops-cli#why-both-shell-and-go)) to build the script that create a new post, update meta information and commit & push to GitHub.
- Use Ansible to deploy and update the server
- Vagrant

> In fact, I find it easier to use Travis + S3 (or [Drone](https://github.com/drone/drone) + [Minio](https://github.com/minio/minio) ) to build and publish the static site, but they may not meet the requirements.


# Getting Started

## Requirements

- [**Vagrant**](https://www.vagrantup.com/)
- [**Ansible**](https://www.ansible.com/)


> For testing purposes only，I uploaded a deploy key. ***You should never do this in a real project!***


## Create a new post or make a tag

Get cli and start a box:

```shell
$ git clone https://github.com/kaleocheng/test-devops-cli.git
$ cd test-devops-cli/box
$ ./start-box.sh
```

Init with `cli.sh`:

```shell
$ vagrant ssh
$ cd $GOPATH/src/github.com/kaleocheng/test-devops-cli
$ ./cli.sh init
```

Create a post, increment version by 0.0.1 and then commit & push:
```shell
$ ./cli.sh dev
```

Increment version by 0.1.0 and then commit & push:
```shell
$ ./cli.sh staging
```

## Automated task to run the create script

```shell
$ vagrant ssh
$ crontab -e
# Generate new page and push to github every 10 minutes
*/10 * * * * eval "$(ssh-agent)" && ssh-add ~/.ssh/id_rsa && cd /home/ubuntu/workspace/src/github.com/kaleocheng/test-devops-cli && ./cli.sh dev

# tag and push to github every 1 hour.
0 * * * * eval "$(ssh-agent)" && ssh-add ~/.ssh/id_rsa && cd /home/ubuntu/workspace/src/github.com/kaleocheng/test-devops-cli && ./cli.sh staging
```

## Deploy and Update the static site
Get the ansible scripts (you may want to change the host and defaults/main.yml):

```shell
$ git clone https://github.com/kaleocheng/test-devops-ansible.git
```
Install requirements and then just play:

```shell
$ ansible-galaxy install -r requirements.yml
$ ansible-playbook -i hosts site.yml
```

Access your site for now. 

Demo:

- [http://dev.kaleo.run](http://dev.kaleo.run)
- [http://staging.kaleo.run](http://staging.kaleo.run)



**For more details such as 'how it works,' just go to the each repo's README.**

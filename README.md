# Wiredcraft DevOps - Modular Test

## Preamble
Working at DevOps team you will need to have a wide range of IT skills, main areas are:
- infrastructure and networking
- CI/CD tools
- microservice architecture and Kubernetes
- configuration managements and automation
- system administration
- IT security
- SRE

The mindset and ability to think out of the box is a critical asset for DevOps. We don't expect everyone to know everything about everything, but we need them to have the mindset and critical thinking to dig into issues. We expect the DevOps engineers to use their skills to overcome difficulties and come with solutions or approaches to solutions.

This is the reason the target of this task is quite broad and may involve technologies you may not (yet) be familiar with.

## Background 

The purpose of this test is to:
- evaluate your technical knowledge
- evaluate your communication with the team
- evaluate your ability to learn


## Test description

This modular test consists of few stand alone tasks. We believe that interview tests shouldn't be a whole day project, so we allow you to choose **any number** of task you want to work on and submit finally.

### Task 1. Scripting language

#### Technical stack
Here is the list of the technologies that we use at Wiredcraft and want you you to use in this task:
- Python
- Shell scripting

#### Task description
You are working with a website, based on a static site generator ([Hugo](https://gohugo.io/)). Prepare a script that will:
- create a new post in your site with a random post content (use the output of [`fortune`](http://manpages.ubuntu.com/manpages/xenial/man6/fortune.6.html) command for example)
- generate the static content of the website
- git commit changes and push it to upstream repo

A few suggestions / recommendations:
- Prepare the basic site, plenty of tutorials are available online ([Hugo](https://gohugo.io))
- Prepare templates for your site generator

### Task 2. Configuration management

#### Technical stack
Here is the list of the technologies that we use at Wiredcraft and want you you to use in this task:
- Ansible

#### Task description
You need to spawn a fresh server for a new project consisting of: API service, database. For simplicity limit this setup to 1 server only. Create an Ansible projects with sample inventory and playbooks for:
- initial setup of the server
- database of your choince
- deployment of API (Docker image; assume it's already built and is stored on company private rigestry `https://registry.wiredcraft.cn/wcl/api:latest` )
- configuration of a web server to point to API service (assume port `3000`is used)
- any maintenance setups (database backups)

### Task 3. Infrastructure as a code 

#### Technical stack
Here is the list of the technologies that we use at Wiredcraft and want you you to use in this task:
- Terraform

#### Task description
You need to spawn an infrastructure for new company project from Task 2. Please create a Terraform project with cloud provider of your choice.

NOTE: finishing task 2 is **not** required for this task

### Task 4. Docker and a bit of Dev
#### Task description
Your need to create and conternize a mock API service. Deliverables:
- an API codebase with one endpoint returning mock response,
- Dockerfile to containerize your API

Choose whichever programming language and framework you like.

### Task 5. Kubernetes 
#### Task description
For the mock API from Task 4 your need to write k8s object definition for the following:
- service
- deployments
- hpa

### Task 6. CI/CD

#### Technical stack
Here is the list of the technologies that we use at Wiredcraft and want you you to use in this task:
- Github Actions
- Azure DevOps pipelines

#### Task description
Crate CI pipeline that would run any of:
- unit tests suite for the API from Task 4 on Pull Requests,
- Build docker image on Pull Request merge 

Also, Create CD pipeline that would do any of:
- deploy new version of the API from Task 4 with any trigger of your choice (assume that deployment service is a stand alone Docker container running on a host server)

## What We Care About

Feel free to schedule your work, ask questions.

We're interested in your method and how you approach the problem just as much as we're interested in the end result.

Here's what you should aim for:

- Use git to manage code
- Comments in your scripts
- Comments in your playbooks
- Clean README file that explains how things work
- Extensible work / code (use variables, limit hardcoded values, etc.)

## Q&A

- Where should I send back the result when I'm done?

Create either a public GitHub repo and push the code there, or simply archize the project and send via an e-mail to us.

- What if I have question?

Send us an email to devops@wiredcraft.com or hr@wiredcraft.com 

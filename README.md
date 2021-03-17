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
You are working with a website, based on a static site generator ([Hugo](https://gohugo.io/)). Prepare a script that will create a new post in your site with a random post content (use the output of [`fortune`](http://manpages.ubuntu.com/manpages/xenial/man6/fortune.6.html) command for example)
A few suggestions / recommendations:
- Prepare the basic site, plenty of tutorial are available online:
    - [Hugo](https://gohugo.io)
- Prepare templates for your site generator:
    - base template for your site to display the `version` in the footer of the pages

### Task 2. Configuration management

#### Technical stack
Here is the list of the technologies that we use at Wiredcraft and want you you to use in this task:
- Ansible

#### Task description
You need to spawn a new service for your company (private docker registry, wiki pages, monitoring dashboard). For simplicity limit this task to 1 server setup. Create an Ansible projects with sample inventory and playbooks for:
- initial setup of the server
- deployment of the service of your choice
- any maintenance setups (DB backups)

### Task 3. Infrastructure as a code 

#### Technical stack
Here is the list of the technologies that we use at Wiredcraft and want you you to use in this task:
- Terraform

#### Task description
You need to spawn an infrastructure for new company service from Task 2. Please create a Terraform project with cloud provider of your choice to create spawn spawn an infrastructure.

### Task 4. Docker and a bit of Dev
#### Task description
Your need to create and conternize a mock API service. Deliverables:
- an API codebase with one endpoint returning mock response,
- Dockerfile to containerize your API

Choose whichever programming language and framework you like.

### Task 5. Kubernetes 
#### Task description
For the mock API from task 4 your need to write k8s object definition for the following:
- service
- deployments
- hpa

### Task 6. CI/CD

#### Technical stack
Here is the list of the technologies that we use at Wiredcraft and want you you to use in this task:
- Github Actions
- Azure DevOps pipelines
- Bamboo 

#### Task description
Crate CI pipeline that would run any of:
- unit tests suite for the API from Task 4 on Pull Requests,
- Build docker image on Pull Request merge 

Also, Create CD pipeline that would do any of:
- deploy new version of the API from Task 4 with any trigger of your choice

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

Fork [this repo](https://github.com/Wiredcraft/test-devops)  and send us a pull request when you think you are done.

- What if I have question?

Create a new issue in the repo and we will get back to you very quickly. You can also send us an email to devops@wiredcraft.com or hr@wiredcraft.com 
## Extra

If there is a need for servers, let us know, we can provision boxes for the tests.

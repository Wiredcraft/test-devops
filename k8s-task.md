# Wiredcraft DevOps - Demo API CI/CD on Minikube

Make sure you read **all** of this document carefully, and follow the guidelines in it.

## Background

The purpose of this test is to:

- evaluate your technical knowledge
- evaluate your communication with the team
- evaluate your ability to learn

## Preamble

DevOps at wiredcraft involves a lot of different technologies and DevOps engineers are expected to be able to navigate through them efficiently.

The mindset and ability to think out of the box is a critical asset for DevOps. We don't expect everyone to know everything about everything, but we need them to have the mindset and critical thinking to dig into issues. We expect the DevOps engineers to use their skills to overcome difficulties and come with solutions or approaches to solutions.

This is the reason the target of this task is quite broad and may involve technologies you may not (yet) be familiar with.

## Technical stack

Here is the list of the technologies that we can use in the test:

- [**Ansible**](https://www.ansible.com/)
- [**minikube**](https://kubernetes.io/docs/tasks/tools/#minikube)
- **Git**
- GitHub actions
- Programming Language: **Python** / **Go** / **Shell** or any other language.

## Task

The test is composed of 2 components:
- a **dev** related task; where you'll be expected to prepare a simple hello world API,
- an **ops** related task; where you'll be expected to provision minikube cluster and deploy the API from `dev` part of this test.

**Make sure you create appropriate documentation on how to run your code and playbook. Create a `README.md` file for that purpose, or store the documentation in a `docs/` folder.**

### Development task

You will need to create:
- an API with one endpoint returning system time in JSON object,
- Docker file to containerize your API

A few suggestions / recommendations:

- Choose whichever programming language and framework you like

### Operation

You will need to:
- create a temp server on Aliyun, Qingcloud, Tencent, etc. (use Terraform to earn extra karma points)
- write an Ansible playbook to configure a server we provide
- that server needs to have:
    - docker registry to host your API images,
    - minikube
- use Github Actions to:
    - CI: build new image and push to your registry every time you merge updates to master
    - CD: on every new tag created you need to deploy the API onto minikube
- your API should be publicly available   


# Getting Started

There's nothing here, we leave it to you to choose the code structure, framework, testing approach...

# Requirements

- With clear documentation on how to run the code
- Use git to manage code

# What We Care About

Feel free to schedule your work, ask questions.

We're interested in your method and how you approach the problem just as much as we're interested in the end result.

Here's what you should aim for:

- Comments in your scripts
- Comments in your playbooks
- Clean README file that explains how things work
- Extensible work / code (use variables, limit hardcoded values, etc.)

# Q&A

- Where should I send back the result when I'm done?

Fork this repo and send us a pull request when you think you are done. We don't have deadline for the task.

- What if I have question?

Create a new issue in the repo and we will get back to you very quickly. You can also send us an email to devops@wiredcraft.com 

# Extra

If there is a need for servers, let us know, we can provision boxes for the tests.

# Wiredcraft DevOps test

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

Here is a list of a few technologies that will be used in this test:

- **Ansible**; for automation
- **Docker's ecosystem**; for containers, network, etc.
- **Vagrant**; for dev environment
- **Git**; for code versioning
- **Python**; as dev language (alternatives are welcome)
- **Django**; as web framework (alternatives are welcome)
- **PostgreSQL**; as database (alternatives are welcome)

## Task

We want to run a bunch of apps on a swarm cluster spread across 3 hosts, relying on a backend database. We want to be able to increase the amount of workers (apps) easily via CLI.

A suggested approach and deliverables:

- A Vagrantfile that contains the definition of the 3 hosts; choose either existing docker box from vagrantcloud, or a base box + provision script. Make it flexible so you can update the CPU / RAM, etc.
- Rely on Docker engine for swarm / service discovery
- Create your ansible playbooks and build your Docker images (DB/apps) using [ansible-container](https://github.com/ansible/ansible-container)
- Use compose to orchestrate your containers
- A complete documentation on how to run / build / deploy the previous tasks

# Getting Started

There's nothing here, we leave it to you to choose the build tool, code structure, framework, testing approach...

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

Create a new issue in the repo and we will get back to you very quickly. You can also jump on Slack and talk with us.

# Extra

If there is a need for servers, let us know, we can provision boxes for the tests.


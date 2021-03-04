# Wiredcraft DevOps - Static website generator and build flow

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

- [**Terraform**](https://www.terraform.io/)
- [**Ansible**](https://www.ansible.com/)
- [**Hugo**](https://gohugo.io/) static site generator
- **Git**
- Programming Language: **Python** / **Go** / **Shell** or any other language.

## Task

The test is composed of 2 components:
- a **dev** related task; where you'll be expected to prepare a simple site using a static site generator,
- an **ops** related task; where you'll be expected to spawn a server to run and operate the site you've created.

**Make sure you create appropriate documentation on how to run your code and playbook. Create a `README.md` file for that purpose, or store the documentation in a `docs/` folder.**

### Development task

You will need to create:
- a site, based on a static site generator (Jekyll or Hugo),
- a script that will create a new post in your site, and update some meta data information (version - see below), eventually pushing the changes back to github.

A few suggestions / recommendations:

- Choose whichever static site generator to use and prepare the basic site, plenty of tutorial are available online:
    - [Hugo](https://gohugo.io)
- Prepare templates for your site generator:
    - base template for your site to display the `version` in the footer of the pages, and a list of the posts on the landing page,
    - post template that will display the content of individual pages
- Prepare a script (choose whichever language) that will take one parameter:
    - either `dev`, in which case, it will:
        - create a new post using markdown with yaml frontmatter format,
        - use the output of [`fortune`](http://manpages.ubuntu.com/manpages/xenial/man6/fortune.6.html) command as content,
        - and increment the version of the site by `0.0.1`,
        - compile the site,
        - commit and push the sources (markdown files) and build site (html) back to github
    - or `staging`, in which case, it will:
        - take the last known version of the site,
        - increment the version of the site by `0.1.x` (e.g. move from `0.1.5` to `0.2.0`)
        - compile the site
        - commit, tag and pus to github

### Operation

You will need to:
- spawn a server with terraform in aliyun/gcp/aws/digital-ocean or use [Vagrant](https://www.vagrantup.com/) to spawn server locally
- write an ansible playbook to configure a server
- that server needs to serve:
    - the dev environment,
    - the staging (tag based) environment
- use Github Actions to:
    - update the dev for every new commit
    - update the staging for every new tag
- get everything to run together!

A few suggestions / recommendations:

- Spawn a box with:
    - Nginx with configuration supporting two domains: dev & staging
    - Go

- Configure the box to run the compile steps on the box:
    - Compile and build the code (Hugo)
    - Deploy the dev / staging environments accordingly.

- Prepare automated task to run the created script mentioned in development part.
    - Generate new page and push to github every 10 minutes. (run the script for `dev`)
    - tag and push to github every 1 hour. (run the script for `staging`)

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

Fork [this repo](https://github.com/Wiredcraft/test-devops/) and send us a pull request when you think you are done.

- What if I have question?

Create a new issue in the repo and we will get back to you very quickly.

# Extra

If there is a need for servers, let us know, we can provision boxes for the tests.

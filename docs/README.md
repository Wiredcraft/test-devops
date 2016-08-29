# test-devops by Stefan

## Description
Repos for Wiredcraft DevOps - Test - Static website generator and build flow

## status
Current status: **NOT FINISHED YET**

## Structure

The structure of this repo is as below:

- dev: including scripts to make new post and publish
- ops: include playbooks to control the whole stuff
- test-blog-compiled: sub-repo for site compiled project
- test-blog: sub-repo for site project source files
- README.md: Instructions


## Technical stack

Here is the list of the technologies that's used in the test:

- [**Ansible**](https://www.ansible.com/)
- [**Jekyll**](https://jekyllrb.com/) static site generator
- **Git**
- Programming Language: **Python** / **Shell** .

### Development task

I wrote two scripts in python to do tasks as below.

- iteration.py: To interact with github for new post generation and publishing
    - Accept args as below:
         - dev: generate new post and publish
             - create a new post using markdown with yaml frontmatter format,
             - use the output of [`fortune`](http://manpages.ubuntu.com/manpages/xenial/man6/fortune.6.html) command as content,
             - and increment the version of the site by `0.0.1`,
             - compile the site,
             - commit and push the sources (markdown files) and build site (html) back to github
         - staging: make a staging release
             - take the last known version of the site,
             - increment the version of the site by `0.1.x` (e.g. move from `0.1.5` to `0.2.0`)
             - compile the site
             - commit, tag and pus to github
         - iteration: continuously dev and staging
             - invoke dev actions with an interval (e.g. 10 minutes)
             - invode staging actions after a number (e.g. 6) of dev actions was maden


- deployment.py: To make continuous deployment with automation. It was controlled by ansible playbooks to be deployed on the site server, and accept no extra args


### Operation Tasks

For operation tasks with ansible i prepared playbooks as below.

- main.yml: the main playbook as the entry for starting magic, and get everything to run together! (See **Get Started** for how to start.)
- staging: as the inventory for all playbooks
- vars.yml: as variables source, in which to configure all variables that's used to control the whole stuff.
- prepare.yml: a playbook for get started, like prepare inventory and variables.
- start.sh: a shell script just used to invoke the main.yml
- Roles: ansible roles to make deployment tasks as seperated modules.
        - nginx: to configure nginx server
        - jekyll: to prepare jekyll tools suite.
        - web_dev: to deploy site of dev domain
        - web_staging: to deploy site of staging domain.
        - iteration: configure target host for continuous deveployment and publish releases. Do tasks mainly including:
                - Generate new page and push to github every 10 minutes. (run the script for `dev`)
                - tag and push to github every 1 hour. (run the script for `staging`)
        - consdeploy: To deliver continuous deployment service, do tasks below
                - fetch the codebase of your site from github every N minutes,
                - update the dev for every new commit
                - update the staging for every new tag

# Getting Started

- Please follow below steps to get started:
    - Make a git clone or pull request to fetch the codes into local
    - Naviagte into test-devops/ops/
    - Run script start.sh to start my craft:
    - Specify arguements as script running to make craft work as desired.(This part is not finished yet!)

# Requirements

- The stuffs here were only tested on Ubuntu 16.04 platform for a time matter
(Pretty sure it won't work on RHEL without modifications)
- To make the stuffs to run, you need below environments at least:
        - Python 2.7 +
        - Ansible (2.0 + Recommended)

# Q&A

- What if I have question? (May **Getting Started** could guide you from start.)

Send me an email or talk with on the cool stuff: Slack then I can get back to you very quickly.

# Extra

Thanks for guy's help from Wiredcaft

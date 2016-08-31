# test-devops by Stefan

## Description
Repos for Wiredcraft DevOps - Test - Static website generator and build flow

## Status
Current status: **Finished**

## Structure

The structure of this repo is as below:

- **dev**: including scripts to make new post and publish
- **ops**: include playbooks to control the whole stuff
- **test-blog-compiled**: sub-repo for site compiled project
- **test-blog**: sub-repo for site project source files
- **README.md**: Instructions


## Technical stack

Here is the list of the technologies that's used in the test:

- [**Ansible**](https://www.ansible.com/)
- [**Jekyll**](https://jekyllrb.com/) static site generator
- **Git**
- Programming Language: **Python** / **Shell** .

# Task Sections

## Development task

I wrote two scripts in python to do tasks as below.

- **iteration.py**: To interact with github for new post generation and publishing
    - Accept args as below:
         - **dev**: generate new post and publish
             - create a new post using markdown with yaml frontmatter format,
             - use the output of [`fortune`](http://manpages.ubuntu.com/manpages/xenial/man6/fortune.6.html) command as content,
             - and increment the version of the site by `0.0.1`,
             - compile the site,
             - commit and push the sources (markdown files) and build site (html) back to github
         - **staging**: make a staging release
             - take the last known version of the site,
             - increment the version of the site by `0.1.x` (e.g. move from `0.1.5` to `0.2.0`)
             - compile the site
             - commit, tag and pus to github
         - **iteration**: continuously dev and staging
             - invoke dev actions with an interval (e.g. 10 minutes)
             - invode staging actions after a number (e.g. 6) of dev actions was maden


- **consdeploy.py**: To make continuous deployment with automation. It was controlled by ansible playbooks to be deployed on the site server, and accept no extra args


### Operation Tasks

For operation tasks with ansible i prepared playbooks as below.

- **main.yml**: the main playbook as the entry for starting magic, and get everything to run together! (See **Get Started** for how to start.)
- **staging**: as the inventory for all playbooks
- **vars.yml**: as variables source, in which to configure all variables that's used to control the whole stuff.
- **prepare.yml**: a playbook for get started, like prepare inventory and variables.
- **start.sh**: a shell script just used to invoke the main.yml
- **Roles**: ansible roles to make deployment tasks as seperated modules.
    - **nginx**: to configure nginx server
    - **jekyll**: to prepare jekyll tools suite.
    - **deploy**: to deploy site for dev and staging domain
    - **web_dev**: to deploy site of dev domain
    - **web_staging**: to deploy site of staging domain.
    - **iteration**: configure target host for continuous deveployment and publish releases. Do tasks mainly including:
            - Generate new page and push to github every 10 minutes. (run the script for `dev`)
            - tag and push to github every 1 hour. (run the script for `staging`)
    - **consdeploy**: To deliver continuous deployment service, do tasks below
            - fetch the codebase of your site from github every N minutes,
            - update the dev for every new commit
            - update the staging for every new tag
    - **stopiter**: Used to stop Continuous Iteration
    - **stopdepl**: Used to stop Continuous Deployment

## Repository

Below GitHub repos will be used for the test:
- [`test-devops`](https://github.com/devfans/test-devops): The main repo where my craft lives
- [`test-blog`](https://github.com/devfans/test-blog): The site project source codes repo
- [`test-blog-compiled`](https://github.com/devfans/test-blog-compiled): The site project compiled codes repo

# Getting Started

- Please follow below steps to get started:
    - Make a git clone or pull request to fetch the this repo into local
    - Naviagte into **test-devops/ops/**
    - Run script **start.sh** to start my craft.(Please define all variables in **plabooks/vars.yml** file!)
    - Specify arguements as script running to make craft work as desired:

```    
[stefan@ops]$ . start.sh
-----------------------------------------------------------------------------------------------------------
Please define all variables in plabooks/vars.yml file!
-----------------------------------------------------------------------------------------------------------
Please specify the host as the target server: (using root user as default, will prompt for password.)
test-devops-stefan
-----------------------------------------------------------------------------------------------------------
Please specify the action you want make, tips as below:
========================
deploy     :   Deploy dev/staging sites from scratch!
dev        :   Deploy dev domain site from scratch!
staging    :   Deploy staging domain site from scratch!
consdeploy :   Continuously deploy dev/staging when update is required(Will deploy dev/staging at first.)
iteration  :   Continuously generation new post, compile project, commit/push to project repo!
stopdepl   :   Stop Continuously deployment!
stopiter   :   Stop Continuously iteration!
========================
Specify action:
iteration
-----------------------------------------------------------------------------------------------------------
Press enter to start the magic...  !!!

Starting tasks
-----------------------------------------------------------------------------------------------------------
```
- Prepare host info for site dev/Staging:
  - Please append blow host info into local hosts file (Replace the **ip** with the your target host ip)
  ```
  139.59.240.152 dev staging
  ```
- Browse the sites:
  - http://dev/
  - http://staging/


# Requirements

- The stuffs here were only tested on Ubuntu 16.04 platform for a time matter
(Pretty sure it won't work on RHEL without modifications)
- To make the stuffs to run, you need below environments at least
    - Python 2.7 +
    - Ansible (2.0 + Recommended)
- For remote server access.
    - use ssh keys to avoid password prompt
    - **(Default)**when using password with **-k** parameter for ansible-playbook, please also disable host key checking in ansible config file

# Q&A

- What if I have question? (May **Getting Started** could guide you from start.)

Send me an email (stefanliu@outlook.com) or talk with me on the cool stuff: Slack then I can get back to you very quickly.

# Extra

Thanks for guy's help from Wiredcaft

# Introduce

## Abstract

There are 4 files commited. The file named build.py is designed to finish the development task. The remaining 3 files provides a systematic tool for operation task. The following is divided into 2 parts: requirements and how to use, talk about method to slove problem

### Usage

#### Scritpt for development task

Firstly, i assume you run the script on local computer instead of web server. You need to ensure the following conditions:

* Python 2 (versions 2.7 higher) or Python 3

* Install these package by pip
    - beautifulsoup4
    - gitpython
    - toml

* Install hugo(version 0.30.0 or higher)

* Init git repo or clone from remote by youself

Secondly, create new site and clone template.

```
cd [your repo path]

hugo new site .

git init

git submodule add https://github.com/h2so4gun/customtemplate.git themes/beg;\

echo 'theme = "beg"' >> config.toml
```

Finally, copy build.py to site directory.

''
python build.py [staging/dev]
''

#### Playbooks and script for operation task

Requirements for ansible control machine:

* Python 2.7.* or Python3

* Install flask by pip

* Copy deploy_staging.yml and deploy_test.yml to /root/playbook

* Configure the target host and repo address in playbook

Requirements for target server:

* Git(version 2 or higher)

Requirements for github:

* Configure the webhook

Last of all, running the webapi.py.

### How it works

#### Developmet Task

In build.py, i wrote 6 functions and set up an argparser to recive the args came from command line. First of all, `update_config` function read `config.toml` file and create the specified version.
In the next step, `write_version` write the version in template. According to the different args, script will make different actions. If arg is "dev", script will create new post. If arg is "staging", scirpt will write new tag in git. Finally, `git_operate` commit code and push to origin.

#### Operation Task

Reading operationflow.png thx.

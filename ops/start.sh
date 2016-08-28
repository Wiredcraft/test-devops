#!/bin/bash

cd playbooks/ && ansible-playbook -e 'host_key_checking=False' -i staging init-deploy.yml -k

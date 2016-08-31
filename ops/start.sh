#!/bin/bash
echo "-----------------------------------------------------------------------------------------------------------"
echo "Please define all variables in plabooks/vars.yml file!"
echo "-----------------------------------------------------------------------------------------------------------"
echo "Please specify the host as the target server: (using root user as default, will prompt for password.)"
read host
echo "-----------------------------------------------------------------------------------------------------------"
echo "Please specify the action you want make, tips as below:"
echo "========================"
echo "deploy     :   Deploy dev/staging sites from scratch!"
echo "dev        :   Deploy dev domain site from scratch!"
echo "staging    :   Deploy staging domain site from scratch!"
echo "consdeploy :   Continuously deploy dev/staging when update is required(Will deploy dev/staging at first.)"
echo "iteration  :   Continuously generation new post, compile project, commit/push to project repo!"
echo "stopdepl   :   Stop Continuously deployment!"
echo "stopiter   :   Stop Continuously iteration!"
echo "========================"
echo "Specify action:"
read action
echo "-----------------------------------------------------------------------------------------------------------"
echo "Press enter to start the magic...  !!!"
read entry
echo "Starting tasks"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
echo "-----------------------------------------------------------------------------------------------------------"
cd playbooks/
ansible-playbook -e 'host_key_checking=False' prepare.yml --extra-vars "host=$host"
ansible-playbook -e 'host_key_checking=False' -i staging main.yml --extra-vars "action=$action"
cd ..
echo "----------------------------------DONE----------------------------------------------------------------------"

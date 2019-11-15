#!/bin/bash

main() {
    cp .vagrant/machines/default/virtualbox/private_key ~/.ssh/vagrant_key_devopstest
    chmod 600 ~/.ssh/vagrant_key_devopstest

    echo "
Host devopstest.com
    HostName devopstest.com
    User vagrant
    Port 22
    StrictHostKeyChecking no
    PasswordAuthentication no
    IdentityFile ~/.ssh/vagrant_key_devopstest
    UserKnownHostsFile /dev/null" >> ~/.ssh/config

}

main 
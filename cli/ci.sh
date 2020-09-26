#!/bin/bash

# setup ssh key

# setup server ip
sed "s/{ ssh_host }/${SERVER_IP}/" ./ansible/inventory-template.cfg > ./ansible/inventory.cfg

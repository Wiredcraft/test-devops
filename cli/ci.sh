#!/bin/bash

# setup ssh key
echo "${SSH_KEY}" > id_rsa
chmod -R 600 id_rsa

# setup server ip
sed "s/{ ssh_host }/${SERVER_IP}/" ./ansible/inventory-template.cfg > ./ansible/inventory.cfg
cat ./ansible/inventory.cfg

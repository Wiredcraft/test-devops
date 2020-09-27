#!/bin/bash

# create ssh key in current dir
pub_key="id_rsa.pub"
private_key="id_rsa"

ssh-keygen -b 2048 -t rsa -f $private_key -q -N ""

# print shh fingerprint
SSH_FINGERPRINT=$(ssh-keygen -lf $pub_key | awk '{print $2}')
echo "ssh fingerprint: ${SSH_FINGERPRINT}"

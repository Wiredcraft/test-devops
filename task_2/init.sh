#! /bin/bash
yum -y install epel-release
yum -y install ansible 
sed  -i 's#\#   StrictHostKeyChecking ask#StrictHostKeyChecking no#'  /etc/ssh/ssh_config

rpm -q sshpass &> /dev/null || yum -y install sshpass  
[ -f /root/.ssh/id_rsa ] || ssh-keygen -f /root/.ssh/id_rsa  -P ''
export SSHPASS="centos"
while read IP;do
   sshpass -e ssh-copy-id  -o StrictHostKeyChecking=no root@$IP
done < hosts.list

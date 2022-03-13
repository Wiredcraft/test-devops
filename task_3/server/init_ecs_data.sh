#!/bin/bash
curl https://ops-deploy-prod-10002-oss.oss-cn-shanghai.aliyuncs.com/xm/saas-init-deploy/saas-deploy.sh|bash
sleep 450
hostip=$(/sbin/ifconfig eth0 | awk '/inet/ {print $2}' | cut -f2 -d ":" |awk 'NR==1 {print $1}')
curl -X POST "https://jenkins.idiaoyan.cn/generic-webhook-trigger/invoke?token=saas-configpush-prod&host_name=$(hostname)&ip_addr=$hostip"
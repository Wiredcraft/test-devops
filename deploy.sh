#!/bin/bash

apt-get install -y unzip
mkdir -p /opt/hugo/dev
cd /opt/hugo/dev
git clone git@github.com:slidemoon/test-devops.git
cd ./test-devops
git checkout shenyi
cd ./quickstart
nohup hugo server -D -p 1313 -b http://dev.test-devops.sh &
mkdir -p /opt/hugo/staging
cd /opt/hugo/staging
git clone git@github.com:slidemoon/test-devops.git
cd ./test-devops
git checkout shenyi
cd ./quickstart
nohup hugo server -D -p 1314 -b http://staging.test-devops.sh &
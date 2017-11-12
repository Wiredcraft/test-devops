#!/bin/bash

apt-get install -y unzip
mkdir -p /opt/hugo/{dev, staging}
cd /opt/hugo/dev
wget https://github.com/slidemoon/test-devops/archive/shenyi.zip
unzip ./shenyi.zip
cd ./test-devops-shenyi/quickstart
nohup hugo server -D -p 1313 &
cd /opt/hugo/staging
wget https://github.com/slidemoon/test-devops/archive/shenyi.zip
unzip ./shenyi.zip
cd ./test-devops-shenyi/quickstart
nohup hugo server -D -p 1314 &
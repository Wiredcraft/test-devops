#!/bin/bash
#set -x
set -e
cd /vagrant/webapp
#Build docker images
echo Building webapp...
docker build -t master.local:5000/webapp-demo .
docker push master.local:5000/webapp-demo

#Start application
echo Deploying webapp...
export DOCKER_HOST=unix:///var/run/swarm.sock
docker-compose pull app
docker-compose up -d

echo All Done! you can access it from http://127.0.0.1:8080

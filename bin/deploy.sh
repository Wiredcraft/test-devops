#!/bin/bash
set -x
cd /vagrant/webapp
#Build docker images
docker build -t master.local:5000/webapp-demo .
docker push master.local:5000/webapp-demo

#Start application
export DOCKER_HOST=unix:///var/run/swarm.sock
docker-compose pull app
docker-compose up -d


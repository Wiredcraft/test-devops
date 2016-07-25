#!/bin/bash
set -x
cd /vagrant/webapp
export DOCKER_HOST=unix:///var/run/swarm.sock
docker-compose scale app=$1

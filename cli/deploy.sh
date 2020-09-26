#!/bin/bash
env=$1
dir="/var/www/${env}"

echo $env
scp -i ./id_rsa -r ./site/public $dir

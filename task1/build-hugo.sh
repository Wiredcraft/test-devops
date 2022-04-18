#!/bin/bash

# build hugo website, centos env

# deploy hugo
# install dependence
yum -y install git golang wget unzip
# create workspace directory
mkdir -p myapp/hugo
wget https://github.com/gohugoio/hugo/releases/download/v0.97.1/hugo_0.97.1_Linux-64bit.tar.gz
tar xf hugo_0.97.1_Linux-64bit.tar.gz -C myapp/hugo
cp myapp/hugo/hugo /usr/local/bin/
# confirm version
hugo version

# create hugo website
hugo new site my_website
cd my_website
git clone https://github.com/chipzoller/hugo-clarity.git themes/hugo-clarity
echo 'theme = "hugo-clarity"' >> config.toml
hugo new posts/my-first-posts.md
# create random value
random=$(openssl rand -base64 8|md5sum|cut -c 1-15)
echo "$random" > content/posts/my-first-posts.md
# build static web
hugo -D

# git management
git config --global user.email "xx@xx.com"
git init
git add .
git commit -m "hugo website"
git push

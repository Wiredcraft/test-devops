#!/bin/bash
# Description: this script is used to generate a random new post for hugo website
# Author: Jerry Yu
# Input Parameter:
# env --> environment, either dev or stating

# Get environment from input
env=$1
version=get_version

function get_version() {
    version = $(awk '/^version/{print $3}' config.toml)
    return version
}

function create_new_post() {
    hugo new posts/new-post.md
    fortune >> content/posts/new-post.md
}

function increase_version(version, env) {
    regex="([0-9]+).([0-9]+).([0-9]+)"
    if [[ $version =~ $regex ]]; then
    first="${BASH_REMATCH[1]}"
    mid="${BASH_REMATCH[2]}"
    last="${BASH_REMATCH[3]}"
    fi

    # check paramater to see which number to increment
    if [[ "$env" == "dev" ]]; then
    last=$(echo $last + 1 | bc)
    elif [[ "env" == "staging" ]]; then
    mid=$(echo $mid + 1 | bc)
    fi

    return ${first}.${mid}.${last}
}

function generate_site(){
  hugo
}

function git_operation(){
  git add .
  git commit -m "updating site content"
  git push origin branch
}

# main function start here

if [ $env == "dev" ]; then
  create_new_post
  increase_version($version, $env)
  generate_site
  git_operation
else if [ $env == "staging" ]; then
  increase_version($version, $env)
  generate_site
  git_operation
fi




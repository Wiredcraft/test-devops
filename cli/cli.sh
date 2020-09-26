#!/bin/bash

function new_post() {
	filepath="posts/$(date +%F-%T).md"
	echo ">> create new post ${filepath}"
  hugo new $filepath
  fortune >> $filepath
}

function publish_dev() {
  new_post()
  ./cli/version.py dev
  hugo
}

function publish_staging() {
  new_post()
  ./cli/version.py staging
  hugo
}

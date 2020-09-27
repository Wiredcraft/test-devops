#!/bin/bash

# usage: increase_minor_version 0.1.1 => 0.2.0
function increase_minor_version() {
  python - "$1" <<EOF
import sys
versions = sys.argv[1].split('.')
minor = int(versions[1]) + 1
print('{}.{}.{}'.format(versions[0], minor, 0))
EOF
}

# usage: increase_patch_version 0.0.1 => 0.0.2
function increase_patch_version() {
  python - "$1" <<EOF
import sys
versions = sys.argv[1].split('.')
patch = int(versions[2]) + 1
print('{}.{}.{}'.format(versions[0], versions[1], patch))
EOF
}

# usage: current_version config.toml
function current_version() {
  cat $1 | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'
}

function new_post() {
  filepath="posts/$(date +%F-%T).md"
  echo ">> create new post ${filepath}"
  hugo new $filepath
  fortune >>content/$filepath
}

# usage: replace_content old_text new_text config.toml
function replace_content() {
  old=$1
  new=$2
  file=$3
  # -i option should be compatibled with linux and macos
  if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' -e s/$old/$new/g $file
  else
    sed -i -e s/$old/$new/g $file
  fi
}

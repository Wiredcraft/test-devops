#!/bin/bash

# usage: increase_patch_version 0.0.1 => 0.0.2
function increase_patch_version() {
  python - "$1" <<EOF
import sys
versions = sys.argv[1].split('.')
v1 = versions[0] if len(versions) >= 1 else 0
v2 = versions[1] if len(versions) >= 2 else 0
v3 = versions[2] if len(versions) >= 3 else 0
try:
  v3 = int(v3) + 1
except:
  pass
print('{}.{}.{}'.format(v1, v2, v3))
EOF
}

# usage: increase_minor_version 0.1.1 => 0.2.0
function increase_minor_version() {
  python - "$1" <<EOF
import sys
versions = sys.argv[1].split('.')
v1 = versions[0] if len(versions) >= 1 else 0
v2 = versions[1] if len(versions) >= 2 else 0
v3 = versions[2] if len(versions) >= 3 else 0
try:
  v2 = int(v2) + 1
  v3 = 0
except:
  pass
print('{}.{}.{}'.format(v1, v2, v3))
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

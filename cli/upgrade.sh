#!/bin/bash
set -e

source ./cli/common.sh

# setup
env=$1
cd site

case $env in
    dev)  echo '========= Publish dev ========='
    # create new post
    new_post
    # upgrade version
    version=$(current_version config.toml)
    new_version=$(increase_patch_version $version)
    replace_content $version $new_version config.toml
    # build site
    hugo
    ;;

    staging)  echo '========= Publish staging ========='
    # upgrade version
    version=$(current_version config.toml)
    new_version=$(increase_minor_version $version)
    replace_content $version $new_version config.toml
    ;;

    *)  echo 'Unknown environment'
    exit 1
    ;;
esac

echo '========= Publish finished ========='

# clean
cd ..

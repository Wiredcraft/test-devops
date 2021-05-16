#!/usr/bin/env bash

#
# This script helps quickly initialize a blog website, and use the theme ananke
# by default. more refer to
#
#   https://gohugo.io/getting-started/quick-start/
#
# NOTE: this scripts should be run only once, if it is called second time, it
# will forcely delete the whole blog directory and create a totally new one.
#

test -d blog && rm -rf blog

hugo new site blog

cd blog

# shadow clone hugo theme ananke, and keep only files not submodule git repo
git clone --depth=1 --single-branch https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
rm -rf themes/ananke/.git

echo theme = \"ananke\" >> config.toml

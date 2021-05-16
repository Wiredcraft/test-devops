#!/usr/bin/env bash

#
# This script helps check the tools required. It will exit error if any tools
# checked missing. You should install the missing tools according to your os
# distribution package management utility. For example on macOS, you can use
#
#   brew install fortune
#
# to install the fortune command tool.
#
set -o pipefail
set -o errexit

for cli in bash git fortune uuidgen hugo; do
    echo checking: $cli
    which $cli > /dev/null && echo OK! || false
done

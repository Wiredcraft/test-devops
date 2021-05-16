#!/usr/bin/env bash

# This script will generate an uniq blog post file name, and write some random
# words.

POST=$(uuidgen).md

cd blog

hugo new posts/$POST

fortune | tee >> content/posts/$POST

hugo -D

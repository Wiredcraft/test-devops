#! /bin/bash
# the scirpt should be under the <Site Name>/content/ directory
# set the post time
POST_TIME=`date +%Y-%m-%dT%H:%M:%S+08:00`

# set the post content random
POST_CONTENT=`fortune`

# generate the posts
POST_FILE=./posts/${POST_TIME}.md


cat > $POST_FILE << EOF
---
title: ${POST_TIME}
date: ${POST_TIME}
draft: false
---

$POST_CONTENT
EOF

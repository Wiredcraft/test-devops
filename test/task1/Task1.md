# Task 1

Operation System:

Mac OSX

## Installation 

```bash
$ brew install hugo
# verification
$ hugo version
```

### Set Up My Own Site

```bash
$ hugo new site MySite
$ cd MySite
$ git init
$ git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
$ echo theme = \"ananke\" >> config.toml
```

## Add some content 

```
$ hugo new posts/my-first-post.md
# the file is located under the directory <site name>/content/posts/
```

## Random Content Script

```bash
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
```

we can set a cron job to genertate posts hourly, daily, weekly or monthly.
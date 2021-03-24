+++
author = "Robert Chu"
title = "Thoughts of this site"
date = "2021-03-19"
description = "Some thoughts and reasons of this site"
tags = [
    "devops",
    "sre",
    "reasons",
    "thoughts",
]
categories = [
    "devops",
    "sre",
]
+++

# Robert Chu - Devops Task
### static site generator chosen
#### Why Hugo, not Jekyll
- more straightforward (installing themes and itself)
- binary (easier) installation
- faster builds
- Go built
- built-in live reload server
- Useful Features (e.g. Menus, sitemaps)
- Thriving community (The most Github stars in all static site generator)
#### Why [Erblog](https://themes.gohugo.io/erblog/) as theme
- mobile responsive
- posts showed in the landing pages

### branchs working rules
- develop
    - any pushed commits here would update to [the site](https://robertchu1205.github.io/) as prd
- dev (*/10 * * * *)
    - create new md to /content/post
    - calculate new version thru **latest pushed commit** or **dev_version in .env** by the rule of dev
    - push back to dev by new version
- staging (0 * * * *)
    - clone from the latest dev
    - calculate new version thru **latest pushed commit** or **dev_version in .env** by the rule of staging
    - push back to staging by new version **with tag**
    - push to develop to update [the site](https://robertchu1205.github.io/)
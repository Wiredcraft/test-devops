#!/bin/bash
set -e
if [ $# -lt 2 ];then
  echo "Usage:$0 contentName"
  exit 
fi
contentName=$1
contentFileName = ${contentName}.md
contentFileNameBak = ${contentFileName}.bak

if [ -f "$contentFileName" ]; then
   echo "The content file is already exists, please provide another content name!"
   exit
fi

function createNewContent()
{
    local randomContent=`fortune`
	`hugo.exe new $contentFileName`
	`mv website-demo/content/$contentFileName website-demo/content/$contentFileNameBak`
	`less website-demo/content/$contentFileNameBak|grep -v 'draft' >website-demo/content/$contentFileName`
	echo $randomContent >> website-demo/content/$contentFileName
	`rm website-demo/content/$contentFileNameBak`
}

function uploadToRemoteRepo()
{
  `git add website-demo/content/$contentFileName`
  `git commit -m "Add a new $contentName content."`
  `git push`
}

createNewContent
uploadToRemoteRepo






#!/bin/bash

#-- this script create a new post for each run
#-- results is demostrated on http://52.36.135.220:1313
POSTTIME=`date +%m%d%H%M%S`
POSTFILE=/home/ubuntu/quickstart/content/posts/POST_${POSTTIME}.md

exec >>  $POSTFILE 

echo "---"
echo "title: MyPost_"${POSTTIME}
echo "date: "$POSTTIME 
echo "draft: false" 
echo "---"
echo 
echo 
fortune 

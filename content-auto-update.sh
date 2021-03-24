#!/bin/bash
### commit msg for posts version control 
if [ "$1" = "dev" ]; then
    fortune=$(eval "fortune")
    today=$(date '+%Y-%m-%d')
    # uppercase in fortune as title and filename
    Title=`echo $fortune | tr -d -c '[:upper:]'` 
    filename="${2}${Title}.md"
    echo $filename
    touch $filename
    # yaml frontmatter below
    echo "+++" >> $filename
    echo "author = \"Robert Chu\"" >> $filename
    echo "title = \"${Title}\"" >> $filename
    echo "date = \"$today\"" >> $filename
    echo "tags = [" >> $filename
    echo "    \"fortune\"," >> $filename
    echo "    \"auto\"," >> $filename
    echo "]" >> $filename
    echo "+++" >> $filename
    echo "$fortune" >> $filename
    # sed -i "s/^tochange.*/${fortune}/" template.md 
elif [ "$1" = "staging" ];then 
    echo "staging"
else
    echo "else"
fi
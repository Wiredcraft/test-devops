#!/bin/bash
### commit msg for posts version control 
if [ "$1" = "dev" ]; then
    fortune=$(eval "fortune")
    today=$(date '+%Y-%m-%d')
    # uppercase in fortune as title and filename
    Title=`echo $fortune | tr -d -c '[A-Zbcdfghjk]'` 
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
    env_staging_ver=$(eval "cat $2 | grep "STAGING_VERSION=*.*.*" | tr -d -c '[0-9 .]'")
    IFS='.' read -a ARR <<< "$env_staging_ver"
    if [ $((${ARR[2]} + 1)) -gt 5 ]; then
	NEW_VER="${ARR[0]}.$((${ARR[1]} + 1)).0"
    else
        NEW_VER="${ARR[0]}.${ARR[1]}.$((${ARR[2]} + 1))"
    fi
    echo $NEW_VER
    sed -i "s/^STAGING_VERSION=.*/STAGING_VERSION=${NEW_VER}/" $2
else
    echo "else"
fi
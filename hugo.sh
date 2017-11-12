#!/bin/bash


HUGO_PATH='./quickstart'


if [ "$1" = 'dev' ]
    then
    echo 'dev'
    VERSION_STR=$(grep 'site_version' ${HUGO_PATH}/data/version.yml)
    str_lenth=${#VERSION_STR}
    dev_str=${VERSION_STR::$(( ${str_lenth}-1 ))}
    dev_last_num=${VERSION_STR: -1}
    dev_new_last_num=$(( ${dev_last_num}+1 ))
    dev_new_str=${dev_str}${dev_new_last_num}
    sed -i '' "s/${VERSION_STR}/${dev_new_str}/g" ${HUGO_PATH}/data/version.yml
    cd ${HUGO_PATH}
    hugo new posts/${dev_new_last_num}.md
    POST_STR=$(fortune)
    echo ${POST_STR} >> ./content/posts/${dev_new_last_num}.md
    cd ..
    git add .
    git commit -m "new dev version ${dev_new_str}"
elif [ "$1" = 'staging' ]
    then
    echo 'staging'
fi

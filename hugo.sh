#!/bin/bash


HUGO_PATH='./quickstart'


if [ "$1" = 'dev' ]
    then
    VERSION_STR=$(grep 'site_version' ${HUGO_PATH}/data/version.yml)
    staging_num=$(echo ${VERSION_STR} |cut -d'.' -f 2)
    str_lenth=${#VERSION_STR}
    dev_str=${VERSION_STR::$(( ${str_lenth}-1 ))}
    dev_last_num=${VERSION_STR: -1}
    dev_new_last_num=$(( ${dev_last_num}+1 ))
    dev_new_str=${dev_str}${dev_new_last_num}
    sed -i '' "s/${VERSION_STR}/${dev_new_str}/g" ${HUGO_PATH}/data/version.yml
    cd ${HUGO_PATH}
    hugo new posts/${staging_num}-${dev_new_last_num}.md
    POST_STR=$(fortune)
    echo ${POST_STR} >> ./content/posts/${staging_num}-${dev_new_last_num}.md
    cd ..
    git add .
    git commit -m "new dev version ${dev_new_str}"
elif [ "$1" = 'staging' ]
    then
    VERSION_STR=$(grep 'site_version' ${HUGO_PATH}/data/version.yml)
    version_num=${VERSION_STR##'site_version: Version '}
    main_num=$(echo ${version_num} | cut -d'.' -f 1)
    staging_num=$(echo ${version_num} | cut -d'.' -f 2)
    new_version_num=${main_num}.$(( ${staging_num}+1 )).0
    sed -i '' "s/${version_num}/${new_version_num}/g" ${HUGO_PATH}/data/version.yml
    git add .
    git commit -m "new staging version ${new_version_num}"
    git tag "${new_version_num}"
fi

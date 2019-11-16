#!/bin/bash
LOCAL_BRANCH=$(git rev-parse --abbrev-ref HEAD)
WWW_ROOT_BASE="/var/www"

get_status_data() {
    # note the the latest tag locally (doing it before git fetch, because fetch updates local tags)
    TAG_LAST=$(git tag | sort -V | tail -1)
    
    git fetch origin 

    REV_LOCAL=$(git rev-parse HEAD)
    REV_REMOTE=$(git rev-parse origin/$LOCAL_BRANCH)

    TAG_LAST_UPDATED=$(git tag | sort -V | tail -1)
}

update_local() {
    git fetch origin 
    git merge origin/$LOCAL_BRANCH
}

check_changes() {
    if [ "${TAG_LAST}" != "${TAG_LAST_UPDATED}" ]; then
        echo "New tag"
        deploy stage "${TAG_LAST_UPDATED}"
        return 1
    else
        echo "There is no new tag"
    fi

    if [ "${REV_LOCAL}" != "${REV_REMOTE}" ]; then
        echo "Remote repository has new commits"
        deploy dev "${REV_REMOTE}"
        return 1
    else
        echo "Remote repository doesn't have new commits"
    fi 
}


deploy() {
    local usage=" USAGE: make_changes <env>
    <env> : Environment parameter (either dev or stage)
    <rev> : Either git hash or tag (756375f3e or 0.1.0)"
    
    # Get environment argument.
    if [ $# != 2 ]; then echo "$usage"; return 1; fi 
    local ENV="${1}"
    local REV="${2}"
    local DEPLOY_ENV="${WWW_ROOT_BASE}/${ENV}"
    local DEPLOY_SOURCE="${DEPLOY_ENV}/${REV}"
    local DEPLOY_LATEST="${DEPLOY_ENV}/latest"
    local DEPLOY_PREVIOUS="${DEPLOY_ENV}/previous"

    git checkout "${REV}"

    mkdir -p "${DEPLOY_SOURCE}"
    cp -r ./website/public/* "${DEPLOY_SOURCE}"
    ln -sfn $(readlink ${DEPLOY_LATEST}) "${DEPLOY_PREVIOUS}"
    ln -sfn "${DEPLOY_SOURCE}" "${DEPLOY_LATEST}" 

    sudo systemctl reload nginx.service

    git checkout "${LOCAL_BRANCH}"
}

main() {
    get_status_data
    update_local
    check_changes
}

main 

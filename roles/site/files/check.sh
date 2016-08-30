#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/vagrant/godir/bin

# check if there is a new commit or tag

# ref: https://stackoverflow.com/questions/3258243/check-if-pull-needed-in-git

set -e

SITE_PATH=/home/vagrant/devops-site
DEV_SITE_PATH=/var/www/dev.com
STAGING_SITE_PATH=/var/www/staging.com

cd $SITE_PATH

git fetch

LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})
BASE=$(git merge-base @ @{u})

# --always fix no tag error: No names found, cannot describe anything
LOCAL_TAG=$(git describe --always @)
REMOTE_TAG=$(git describe --always @{u})

if [ $LOCAL = $REMOTE ]; then
    echo "Up-to-date: commit equal"
elif [ $LOCAL = $BASE ]; then
    echo "Need to pull"
    # pull
    git pull
    # update dev
    rsync -r $SITE_PATH/public/ $DEV_SITE_PATH

    if [ $LOCAL_TAG = $REMOTE ]; then
        echo "tag equal"
    else
        # update staging
        rsync -r $SITE_PATH/public/ $STAGING_SITE_PATH
    fi
elif [ $REMOTE = $BASE ]; then
    echo "Need to push"
else
    echo "Diverged"
fi

cd -

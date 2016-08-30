#!/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/vagrant/godir/bin

# run devops staging

set -e

SITE_PATH=/home/vagrant/devops-site
DEV_SITE_PATH=/var/www/dev.com
STAGING_SITE_PATH=/var/www/staging.com

cd $SITE_PATH

devops staging

# update dev
rsync -r $SITE_PATH/public/ $DEV_SITE_PATH

# update staging
rsync -r $SITE_PATH/public/ $STAGING_SITE_PATH

cd -
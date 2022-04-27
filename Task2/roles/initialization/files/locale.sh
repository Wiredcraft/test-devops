#$!/bin/bash

sudo localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8
sudo export LC_ALL=zh_CN.UTF-8
sudo echo 'LANG="zh_CN.UTF-8"' > /etc/locale.conf 


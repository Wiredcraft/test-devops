#!/bin/bash

#-- variables 
backup_repository=/opt/backup_pg_rman/	
pgdata=/data/pgdata/12

#--backup database to local filesystem		
pg_rman -B ${backup_repository} backup –backup-mode=full –with-serverlog -D ${pgdata} -U postgres –port 5432 –host localhost

#--copy backups to s3
aws s3 cp ${backup_repository}/*  s3://backet_of_backup


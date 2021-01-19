#!/bin/bash

# Author:	Rodrigo Leutz
# Project:	SQL Backup

######### Vars #########

# Number of Backups
BACKNUM=30

# Database => Info for database backup
DBS=('wp-dev' 'mysql')
DOCKER="db-backup"
USER="root"
PASSWD=`cat webdev/docker-compose.yaml | grep MARIADB_MASTER_ROOT_PASSWORD | awk -F: '{ print $2 }' | sed -e 's/^[[:space:]]*//'`

# Paths => 
BACKDIR="backup/files"
BACKLOG="backup/logs"
DATE=$(date +%Y-%m-%d.%H%M)
LOG="$BACKLOG/sql-bkp-$DATE.log"

########################

###### Functions #######
init_bkp(){
	echo "Database Backup - $DATE" > $LOG
	echo "{ INIT }: $(date +%Y-%m-%d.%H:%M:%S)" >> $LOG
}
exit_bkp(){
	echo "{ FINISH }: $(date +%Y-%m-%d.%H:%M:%S)" >> $LOG
	exit 1
}

check_paths(){
	if [ ! -d $BACKDIR ]; then
		echo "CHECK: [ ERROR ] -> Backup files path not exists!" >> $LOG
		ERROR="yes"
	fi
	if [ ! -d $BACKLOG ]; then
		echo "CHECK: [ ERROR ] -> Backup logs path not exists!" >> $LOG
		ERROR="yes"
	fi
	if [ "ERROR" == "yes" ]; then
		exit_bkp
	fi	
}
make_bkp(){
	if sudo docker exec -t $DOCKER mysqldump -u$USER -p"$PASSWD" $1 > $BACKDIR/$DATE-$1.sql
	then
		echo "DUMP: [ SUCCESS ] ->  $(pwd -P)$BACKDIR/$1-$DATE.sql" >> $LOG
	else
		echo "DUMP: [ ERROR ] ->  $(pwd -P)$BACKDIR/$1-$DATE.sql" >> $LOG
		exit_bkp
	fi
}
start_bkp(){
	check_paths
	if sudo docker exec -t $DOCKER mysqladmin -u$USER -p$PASSWD stop-slave
	then
		echo "STOP SERVICE: [ SUCCESS ] -> Service Stoped" >> $LOG
	else
		echo "STOP SERVICE: [ ERROR ] -> Service do not stop" >> $LOG
  		exit_bkp
	fi
	for i in ${DBS[@]}; do
		make_bkp "$i"
	done
	if tar -cJf $BACKDIR/$DATE-SQL.tar.xz $BACKDIR/$DATE-*.sql
	then
		echo "TAR: [ SUCCESS ] ->  $(pwd -P)$BACKDIR/$DATE-SQL.tar.xz" >> $LOG
		rm $BACKDIR/$DATE-*.sql
	else
		echo "TAR: [ ERROR ] ->  $(pwd -P)$BACKDIR/$DATE-SQL.tar.xz" >> $LOG
		ERROR="yes"
	fi
	if sudo docker exec -t $DOCKER mysqladmin -u$USER -p$PASSWD stop-slave
	then
		echo "START SERVICE: [ SUCCESS ] -> Service Started" >> $LOG
	else
		echo "START SERVICE: [ ERROR ] -> Service do not start" >> $LOG
  		exit_bkp
	fi
	if [ "ERROR" == "yes" ]; then
		exit_bkp
	fi	
}
########################

######### Init #########

init_bkp
start_bkp
exit_bkp


########################

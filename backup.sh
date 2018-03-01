#!/bin/bash
#
## BEGIN CONFIG ##
HOST=$(uname -n)
DATABASE_PASS="abt511"
OPENKM_DB="okmdb"
OPENKM_HOME="/home/openkm"
TOMCAT_HOME="$OPENKM_HOME/tomcat-7.0.61"
DATABASE_EXP="$OPENKM_HOME/ABTopenkm/db"
BACKUP_DIR="/home/openkm/ABTopenkm"
RSYNC_OPTS="-apzhR --stats --delete --exclude=*~ --delete-excluded"
## END CONFIG ##

# Check root user 
if [ $(id -u) != 0 ]; then echo "You should run this script as root"; exit; fi

# Delete older local database backup 
echo -e "### BEGIN: $(date +"%x %X") ###\n"
rm -rf $DATABASE_EXP
mkdir -p $DATABASE_EXP
 
# Mount disk
#if mount | grep "$BACKUP_DIR type" > /dev/null; then
#  echo "$BACKUP_DIR already mounted";
#else
#  mount "$BACKUP_DIR";
#  
#  if mount | grep "$BACKUP_DIR type" > /dev/null; then
#    echo "$BACKUP_DIR mounted";
#  else
#    echo "$BACKUP_DIR error mounting";
#    exit -1;
#  fi
#fi
 
# Stop Tomcat
/etc/init.d/tomcat stop
 
# Clean logs
echo "Clean Tomcat temporal files."
rm -rf $TOMCAT_HOME/logs/*
rm -rf $TOMCAT_HOME/temp/*
rm -rf $TOMCAT_HOME/work/Catalina/localhost
 
# Backup database
if [ -n "$DATABASE_PASS" ]; then
  echo "* Backuping MySQL data from $OPENKM_DB..."
  mysqldump -h localhost -u root -p$DATABASE_PASS $OPENKM_DB > $DATABASE_EXP/mysql_$OPENKM_DB.sql
  echo "-------------------------------------";
fi
 
# Create backup
rsync $RSYNC_OPTS $TOMCAT_HOME $BACKUP_DIR/
 
# Start Tomcat
/etc/init.d/tomcat start
echo -e "\n### END: $(date +"%x %X") ###"
 
# Umount disk
#sync
#umount "$BACKUP_DIR"
#
# run tomcat_backup.sh
echo "Calling the tomcat_backup.sh script"
sh /home/openkm/tomcat-7.0.61/tomcat_backup.sh
echo "tomcat_backup.sh complete"
#

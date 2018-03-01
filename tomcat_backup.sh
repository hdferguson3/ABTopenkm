#!/bin/bash
#
#
# tar up tomcat application folder
#
cd /home/openkm/
#tar -czvf /home/openkm/DatabaseArchives/tomcat-$(date +%Y%m%d).tar.gz tomcat-7.0.61
tar -czvf /home/openkm/DatabaseArchives/ABTopenkmBackup-$(date +%Y%m%d).tar.gz /home/openkm/ABTopenkm
#
# mount USB drive
#
sudo mount /dev/sdb1 /mnt/backup
echo "backup mounted"
sudo cp /home/openkm/DatabaseArchives/ABTopenkmBackup-$(date +%Y%m%d).tar.gz /mnt/backup
echo "move sql dump and app folder tar"
find /mnt/backup -mtime +20 mtime -100 -type f -exec rm -f {} \;
echo "purge old files on backup drive"
sudo sync
sudo umount /mnt/backup
echo "unmount backup"
#
# mount abt server
#
sudo mount -t cifs -o username=dferguson,password=dougf1! //192.168.255.3/"ABT Server"/"Project Management"/DatabaseBackups /mnt/DatabaseBackups
echo "mount ABT server"
sudo rm -rf /mnt/DatabaseBackups/*
echo "purge old file"
sudo cp /home/openkm/DatabaseArchives/ABTopenkmBackup-$(date +%Y%m%d).tar.gz /mnt/DatabaseBackups
echo "copy database tar"
sudo sync
sudo umount /mnt/DatabaseBackups
echo "unmount ABT server"
#
# delete backups older than 5 days
find /home/openkm/DatabaseArchives -mtime +5 -mtime -100 -type f -exec rm -f {} \;
echo "purge old files locally"
#
#

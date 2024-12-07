#!/bin/bash

#variables with directories to make backups
DirConf="/etc"
DirHome="/home"
DirVar="/var"

#variables to backups directory, date, and compression filename.
DirBackup="/home/Jason/backups"
Date=$(date +"%Y-%m-%d_%H:%M")
BackupFile="$DirBackup/backup_$Date.tar.gz"

echo "Starting backup of important files..."

#Tar command to compress the backup file to a minimun size.
tar -czf "$BackupFile" "$DirConf" "$DirHome" "$DirVar"

echo "Backup successful!"
echo "Backup stored in path: $BackupFile"

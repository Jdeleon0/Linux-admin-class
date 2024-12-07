#!/bin/bash

#Variables
DirPath="/etc/"  #"/var/log"  		#variable holding path to directory where its gonna make a hash from.
OldHash="/tmp/dir_old_hash.txt"		#variable holding path to directory temp and file where hash will be stored. 
CurrentHash=$(find "$DirPath" -exec stat --format='%n %s %y' {} \; | sha256sum | awk '{print $1}') # using Sha256sum to get the DIR hash.

if [ ! -f "$OldHash" ];then						#If condition to verify that file dir_old_hash.txt exist-
	echo "No hash found, saving current hash for $DirPath."		#if no file exist, creates it and stores the current hash inside.
	echo "$CurrentHash" > "$OldHash"

fi

SavedHash=$(cat "$OldHash")	#variable holding the previous hash using the cat command

if [ "$CurrentHash" == "$SavedHash" ];then		#IF-Else condition to verify if the current and previous hashes are equal, if true-
	echo "No changes detected in $DirPath."		#show both hashes and provide a text stating as such.-
	echo "$CurrentHash"				#Else if false, provides a text notifying a change in hashes, shows them-
	echo "$SavedHash"				#and stores the new hash in the file.
else
	echo "Changes detected in $DirPath!!"
	echo "saving current hash as previous hash"
	echo "Old = $SavedHash"
	echo "New = $CurrentHash"
	echo "$CurrentHash" > "$OldHash"
fi



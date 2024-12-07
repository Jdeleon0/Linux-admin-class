#!/bin/bash 

#variables to be used
Date=$(date +%F)					#Variable holding date in format YYYY-MM-DD
LogFile="/var/log/auth.log"				#Variable holding the path to the authentication log
OutputFile="/var/log/suspicious_access$Date"		#variable holding the path where the script is gonna be saved to
Users="jason"  						#variable holding the users (only me, no need to include a list from passwd or is it?)

echo "		*Looking for suspicious activity:";

{
	echo "		*Logins between 12AM and 6AM:"
	grep -E "T[0][0-5]:[0-9]{2}:[0-9]{2}" "$LogFile" | grep -E "login:auth"  	#grep command to check for unknown users trying to log in	
	echo ""										#betweem midnight and 6AM.

	echo "		*Logins from user '$Users':"
	grep "$Users" "$LogFile" | grep -E "(login:session)"			   	#Grep command to check for login sessions.
	echo ""										#from suspicious user

	echo "		*Detecting all activity involving ssh and open ports:"
	grep "sshd" "$LogFile"	| grep -E "Accepted | Failed | port"			#echo explains it all
	echo ""

}|tee "$OutputFile"					#Tee command gathers all info and saves to path variable

echo "		*Process completed, results are stored in path $OutputFile"

#!/bin/bash 

#gets the current date in format yyyy-mm-dd
Date=$(date +%F)

#variable holding the path where the file will be saved
netlog="/var/log/networkinfo_$Date.txt"

echo "~Getting a summary of current network information~";
echo "------------------------------------------------";
{
	echo "----------Network Info:----------"
	echo "----------Date: $Date----------"
	echo ""

	print "----------IP address:----------"
	ip addr show
	echo ""
	
	echo "----------Default gateway:----------"
	ip route show
	echo ""

	echo "----------DNS information:----------"
	resolvectl status
	echo ""
	
	echo "----------open ports:----------"
	ss -tuln


} |tee "$netlog"  #tee command takes all information and saves it into the path given to the netlog variable.

#informs the user with a comment where the file is stored.
echo "Current network data saved in path $netlog"

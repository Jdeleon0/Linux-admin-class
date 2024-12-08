#!/bin/bash

#variables storing current date and path to log file
DATE=$(date +%F)
LOG="/var/log/monitor_server_health_$DATE.log"
{	echo "			***Health report - $DATE***"

	echo "			***Gathering I|O statistics***"
	iostat		#iostat command is used to monitor I/O activity for devices and partitions.
	echo ""

	echo "			***Memory usage*** "
	free -m		#free command is used to gather the free and used memory on the system, (-m) ouput in MB.
	echo ""

	echo "			***CPU usage***"
	mpstat		#mpstat command delivevers comprehensive CPU utilization and performance data.
	echo""

	echo "			***process list tree*** "
	pstree -a	#pstree command displays running processes in a tree structure, (-a) includes arguments.
	echo ""

	echo "			***network Status***"
	tcpdump -D	#tcpdump command is used to analize network traffic. (-D) display all available interfaces.
	echo ""
	
	echo "			***Server uptime***"
	uptime		#uptime command is used to find for how long the system has been active.
	echo ""
} | tee "$LOG"
echo "Report saved in path: $LOG"

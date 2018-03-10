#!/bin/bash 
REDISCLI="/usr/local/redis/bin/redis-cli -h $1 -p $3" 
LOGFILE="/var/log/keepalived-redis-state.log" 
echo "[master]" >> $LOGFILE 
date >> $LOGFILE 
echo "Being master...." >> $LOGFILE 2>&1 
echo "Run SLAVEOF cmd ... " >> $LOGFILE 
$REDISCLI SLAVEOF $2 $3 >> $LOGFILE  2>&1
#echo "SLAVEOF $2 cmd can't excute ... " >> $LOGFILE 
sleep 1 ##delay 15 s wait data sync exchange role
echo "Run SLAVEOF NO ONE cmd ..." >> $LOGFILE
$REDISCLI SLAVEOF NO ONE >> $LOGFILE 2>&1 

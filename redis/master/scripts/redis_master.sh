#!/bin/bash 
REDISCLI="/usr/local/redis/bin/redis-cli -h $1 -p $3" 
LOGFILE="/var/log/keepalived-redis-state.log" 
echo "[master]" >> $LOGFILE 
date >> $LOGFILE 
echo "Being master...." >> $LOGFILE 2>&1  
echo "Run MASTER cmd ..." >> $LOGFILE 2>&1
$REDISCLI SLAVEOF $2 $3 >> $LOGFILE  
sleep 1 #delay 10 s wait data async cancel sync
echo "Run SLAVEOF NO ONE cmd ..." >> $LOGFILE
$REDISCLI SLAVEOF NO ONE >> $LOGFILE 2>&1

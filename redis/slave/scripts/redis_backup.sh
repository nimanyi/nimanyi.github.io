#!/bin/bash 
REDISCLI="/usr/local/redis/bin/redis-cli" 
LOGFILE="/var/log/keepalived-redis-state.log" 
echo "[BACKUP]" >> $LOGFILE 
date >> $LOGFILE 
echo "Being slave...." >> $LOGFILE 2>&1 
echo "Run SLAVEOF cmd ..." >> $LOGFILE 2>&1
$REDISCLI SLAVEOF $2 $3 >> $LOGFILE  
sleep 1 #delay 10 s wait data async cancel sync 
exit(0)


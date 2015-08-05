#!/bin/bash 


echo "Stop celery .... "
pids=$(ps -ef | grep celery | grep -v grep | grep $USER | awk '{print $2}') 
for pid in $pids
do 
   echo "kill  $pid"
   kill $pid
   sleep 1
done

sleep 3
echo "Stop runserver .... "
pids=$(ps -ef | grep runserver | grep -v grep | grep $USER| awk '{print $2}')
for pid in $pids
do 
   echo "kill  $pid"
   kill $pid
done


source ~/miniconda/bin/deactivate 

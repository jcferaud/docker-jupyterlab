#!/bin/bash

export PODNAME=`hostname`
export DATECREATION=`date +"%d-%h-%y:%T"`

# ********************** verification if database exists ***********************
verif1=`ps -eaf|grep jupyter|grep Notebook`

if [ -z "$verif1" ] ; then
     echo $DATECREATION ": exit 1" >> /opt/jupyter/logs/healthcheck.log             
     echo "exit 1"       
     exit 1
   else
     echo $DATECREATION ": exit 0" >> /opt/jupyter/logs/healthcheck.log             
     echo "exit 0"       
     exit 0
   fi


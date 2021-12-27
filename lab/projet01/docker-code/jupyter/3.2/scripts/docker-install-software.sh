#!/bin/bash

export PODNAME=`hostname`
export DATECREATION=`date +"%d-%h-%y:%T"`
export LOGFILE="$LOGPATH/${PODNAME}-${LOGENTRY}"
export ERRFILE="$LOGPATH/${PODNAME}-${LOGERROR}"


echo "nginx install : Start" >> $LOGFILE
echo "DATE: ${DATECREATION}" >> $LOGFILE

# prerequisite for offline installation
export DEBIAN_FRONTEND="noninteractive"
echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

apt-get update -y

# debian updates (optional)
apt-get install -y iputils-ping
apt-get install -y procps
apt-get install -y sudo
apt-get install -y net-tools
apt-get install -y vim
apt-get install -y tini
apt-get install -y curl

# install python3 + pip3 + jupyter
apt-get install -y python3-pip python3-dev
pip3 install --upgrade pip
pip3 install virtualenv
pip3 install jupyterlab


# install jupyter packages
pip3 install pandas
pip3 install statsmodels
pip3 install matplotlib
pip3 install sklearn
pip3 install mglearn


# end of script
echo "nginx install : END" >> $LOGFILE


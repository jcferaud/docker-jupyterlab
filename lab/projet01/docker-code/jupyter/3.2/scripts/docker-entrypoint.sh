#!/bin/bash

export PODNAME=`hostname`
export DATECREATION=`date +"%d-%h-%y:%T"`
export LOGFILE="$LOGPATH/${PODNAME}-${LOGENTRY}"
export ERRFILE="$LOGPATH/${PODNAME}-${LOGERROR}"

echo -e "\n**********************************************************\n" > $LOGFILE
echo ${DATECREATION} >> $LOGFILE
echo -e "\n**********************************************************\n" > $ERRFILE
echo ${DATECREATION} >> $ERRFILE

echo "My current shell is $SHELL ($0)" >> $LOGFILE

#sudo mkdir /opt/projet01/python-code
#sudo chmod -R 755 /opt/projet01/python-code
#sudo chown -R $USER_UID:$GROUP_GID /opt/projet01/python-code
#sudo cp /opt/jupyter/python-code/* /opt/projet01/python-code/

export NOTEBOOKDIR="/opt/jupyter/jupyter-code/$JUPYTER_SETUP"
echo "NOTEBOOKDIR: $NOTEBOOKDIR" >> $LOGFILE

# if [ $JUPYTER_SETUP = 'notebook02' ]; then
#    export NOTEBOOKDIR="/opt/jupyter/jupyter-code/$JUPYTER_SETUP"
#    echo "NOTEBOOKDIR: $NOTEBOOKDIR" >> $LOGFILE
# fi

# move to scripts directory
cd /opt/jupyter/scripts

# option 1
password1=`/usr/bin/python3 /opt/jupyter/scripts/password-convert-sha256.py $JUPYTER_PASSWORD`
echo "password1: $password1" >> $LOGFILE

# option 2
var2="/usr/bin/python3 ./password-convert-sha256.py $JUPYTER_PASSWORD"
export password2=`eval $var2`
echo "password2: $password2" >> $LOGFILE

# option 3
/usr/bin/python3 /opt/jupyter/scripts/password-convert-sha256.py $JUPYTER_PASSWORD > /opt/jupyter/logs/password-convert-sha256.txt
password3=`cat /opt/jupyter/logs/password-convert-sha256.txt`
echo "password3: $password3" >> $LOGFILE

# option 4 (incomplete)
export pwd4=`echo -n $JUPYTER_PASSWORD | shasum -a 256 | head -n1 |cut -d " " -f1`
export password4="sha256:$pwd4"
echo "password4: $password4" >> $LOGFILE

var="/usr/local/bin/jupyter-lab --ip=$PODNAME --NotebookApp.token='' --NotebookApp.password=$password1 --notebook-dir=$NOTEBOOKDIR"
echo "command to run var: $var" >> $LOGFILE

if [ ${DOCKER_DEBUG_FLAG} = 'yes' ] ; then
  var="/bin/bash"
  echo "forced debug command: $var" >> $LOGFILE
fi



# End
export DATEFIN=`date +"%d-%h-%y:%T"`
echo ${DATEFIN} >> $LOGFILE
echo "docker-entrypoint.sh: End" >> $LOGFILE
echo "**********************************************************" >> $LOGFILE

# check if the debugging option is setup to exit
if [ ${DOCKER_DEBUG_FLAG} != 'exit' ] ; then
   eval $var
fi

#exec "/bin/bash"

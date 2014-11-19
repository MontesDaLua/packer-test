#/bin/bash 

sudo apt-add-repository "deb $BASE_REPO" >>$LOGFILE
sudo apt-get update
sudo apt-get install --force-yes -y bgch-bootstrap >> $LOGFILE 2>&1
sudo -i /usr/lib/bgch/bootstrap/bootstrapper.sh -p $PASSWORD $IDENTIFICATION >> $LOGFILE 2>&1


# force 0 exit status 
echo "done" > /tmp/bootstrapper.log

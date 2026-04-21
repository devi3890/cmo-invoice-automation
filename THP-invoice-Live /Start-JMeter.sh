#!/bin/sh
export JVM_ARGS='-Xmx1g -Xms768m -XX:MaxMetaspaceSize=1g'
export JMETER_HOME=/home/devi/Documents/devi-owner/Apps/apache-jmeter-5.4.1
echo JMETER_HOME=$JMETER_HOME

# DO NOT use this script directly for performance testing, it is designed to be included into other scripts using Include Controller.

# Listed below are default properties for Login reusable script

# ************** Environment Properties - Start **************
export JMETER_PROP=
export JMETER_PROP=$JMETER_PROP" -Djmeter.protocol=https"
export JMETER_PROP=$JMETER_PROP" -Djmeter.serverName=portal.bijib.com"
export JMETER_PROP=$JMETER_PROP" -Djmeter.serverPort=443"
# export JMETER_PROP=$JMETER_PROP" -Djmeter.protocol=http
# export JMETER_PROP=$JMETER_PROP" -Djmeter.serverName=localhost
# export JMETER_PROP=$JMETER_PROP" -Djmeter.serverPort=80
# ************** Environment Properties - End **************

# ************** Performance Properties - Start **************
export JMETER_PROP=$JMETER_PROP" -Djmeter.users=1"
export JMETER_PROP=$JMETER_PROP" -Djmeter.duration=1"
export JMETER_PROP=$JMETER_PROP" -Djmeter.startupDelay=1"
export JMETER_PROP=$JMETER_PROP" -Djmeter.rampup=1"
export JMETER_PROP=$JMETER_PROP" -Djmeter.randomDelay=0"
export JMETER_PROP=$JMETER_PROP" -Djmeter.constantDelay=0"
export JMETER_PROP=$JMETER_PROP" -Djmeter.loopCount=1"
export JMETER_PROP=$JMETER_PROP" -Djmeter.dataFile=../data/master-data.csv"
export JMETER_PROP=$JMETER_PROP" -Djmeter.debug=false"
# ************** Performance Properties - End **************
#
# ************** Application Properties - Start **************
export JMETER_PROP=$JMETER_PROP" -Djmeter.userSessionLoopCount=1"
# ************** Application Properties - End **************
#
echo $JMETER_PROP
$JMETER_HOME/bin/jmeter -t "scripts/thp-invoice-generation-checking.jmx" $JMETER_PROP

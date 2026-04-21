#!/bin/sh

echo "Running JMeter in Jenkins..."

# ✅ Memory settings
export HEAP="-Xms768m -Xmx1g"

# Properties
JMETER_PROP=""
JMETER_PROP="$JMETER_PROP -Djmeter.protocol=https"
JMETER_PROP="$JMETER_PROP -Djmeter.serverName=portal.bijib.com"
JMETER_PROP="$JMETER_PROP -Djmeter.serverPort=443"
JMETER_PROP="$JMETER_PROP -Djmeter.users=1"
JMETER_PROP="$JMETER_PROP -Djmeter.duration=1"
JMETER_PROP="$JMETER_PROP -Djmeter.loopCount=1"

echo "Executing test..."

jmeter -n \
  -t "scripts/ssw-invoice-generation-checking.jmx" \
  -l results/result.jtl \
  $JMETER_PROP

#!/bin/sh

echo "=============================="
echo "Running JMeter in Jenkins"
echo "=============================="

# ✅ Memory settings
export HEAP="-Xms768m -Xmx1g"

# ✅ Move to correct directory (VERY IMPORTANT)
cd "$(dirname "$0")"

echo "Current directory:"
pwd

echo "Listing files:"
ls -l

# ✅ Create result folder safely
mkdir -p result

# ✅ Properties
JMETER_PROP=""
JMETER_PROP="$JMETER_PROP -Djmeter.protocol=https"
JMETER_PROP="$JMETER_PROP -Djmeter.serverName=portal.bijib.com"
JMETER_PROP="$JMETER_PROP -Djmeter.serverPort=443"
JMETER_PROP="$JMETER_PROP -Djmeter.users=1"
JMETER_PROP="$JMETER_PROP -Djmeter.duration=1"
JMETER_PROP="$JMETER_PROP -Djmeter.loopCount=1"

echo "=============================="
echo "Executing Nepean test ONLY"
echo "=============================="

# ✅ Run ONLY Nepean JMX
jmeter -n \
  -t scripts/nepean-invoice-generation-checking.jmx \
  -l result/nepean-result.jtl \
  $JMETER_PROP

echo "=============================="
echo "Test execution completed"
echo "=============================="

# ✅ Show results
echo "Result files:"
ls -l result

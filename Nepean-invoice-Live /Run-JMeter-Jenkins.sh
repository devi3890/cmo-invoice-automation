#!/bin/sh
echo "=============================="
echo "Running JMeter in Jenkins"
echo "=============================="

cd "$(dirname "$0")"
echo "Current directory:"
pwd
echo ""
echo "Listing files:"
ls -l

mkdir -p result
mkdir -p logs

export HEAP="-Xms768m -Xmx1g"

JMETER_PROP=""
JMETER_PROP="$JMETER_PROP -Djmeter.protocol=https"
JMETER_PROP="$JMETER_PROP -Djmeter.serverName=portal.bijib.com"
JMETER_PROP="$JMETER_PROP -Djmeter.serverPort=443"
JMETER_PROP="$JMETER_PROP -Djmeter.users=1"
JMETER_PROP="$JMETER_PROP -Djmeter.duration=1"
JMETER_PROP="$JMETER_PROP -Djmeter.loopCount=1"

echo ""
echo "=============================="
echo "Executing Nepean test ONLY"
echo "=============================="

if [ ! -f "scripts/nepean-invoice-generation-checking.jmx" ]; then
    echo "ERROR: JMX file not found!"
    exit 1
fi
echo "JMX file found"

jmeter -n \
  -t "scripts/nepean-invoice-generation-checking.jmx" \
  -l "result/nepean-result.jtl" \
  -j "logs/jmeter.log" \
  -Djmeter.save.saveservice.output_format=xml \
  $JMETER_PROP

JMETER_EXIT_CODE=$?

echo ""
echo "=============================="
echo "Test execution completed"
echo "=============================="

echo "Result files:"
ls -l result || true
echo ""
echo "Log files:"
ls -l logs || true

if [ -f "result/nepean-result.jtl" ]; then
    echo "Result file generated successfully"
else
    echo "Result file NOT generated"
    exit 1
fi

if [ $JMETER_EXIT_CODE -ne 0 ]; then
    echo "JMeter execution failed"
    exit $JMETER_EXIT_CODE
fi

echo "Script completed successfully"

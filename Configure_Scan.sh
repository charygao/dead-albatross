#!/bin/bash
if [ $# -eq 0 ]
then
  echo
  echo "You need to supply a SCAN_ID to configure."
  echo "Eg. "$0 $RANDOM
  echo
else
  aKey=12345678
  sKey=abcdefgh
  iScan=$1
  curl --verbose 'https://cloud.tenable.com/scans/'$iScan \
    -X PUT \
    -H "X-Impersonate: username=jansuz@une.edu.au" \
    -H "X-ApiKeys: accessKey=$aKey;secretKey=$sKey" \
    -H "Content-Type: application/json" \
    -d @ten_configure_scan.json
  echo
  echo "Done..."
fi

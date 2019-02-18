#!/bin/bash
aKey=123
sKey=abc
oFile=Scans_to_stop.json
uName=ronald@mcdonalds.com

curl -# -H "X-Impersonate: username=$uName" -H "X-ApiKeys: accessKey=$aKey; secretKey=$sKey" https://cloud.tenable.com/scans | jq > $oFile

for n in $(grep -E id $oFile | grep -v uuid | cut -d: -f2 | sort -n)
  do 
	# curl --verbose 'https://cloud.tenable.com/scans/'${n}'/stop' \
    curl 'https://cloud.tenable.com/scans/'${n}'/stop' \
    	-X POST \
        -H "X-Impersonate: username=$uName" \
        -H "X-ApiKeys: accessKey=$aKey;secretKey=$sKey" \
        -H "Content-Type: application/json"
  	echo
  done

rm $oFile

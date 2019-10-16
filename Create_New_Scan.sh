#!/bin/bash

if [ $# -eq 0 ]; then
	echo -e "\nYou need to specify a JSON file with the scan configuration in it.\n"
	exit 99
else 
	FileName=${1}
	aKey=$(grep A: keys.cfg | cut -d: -f2)
	sKey=$(grep S: keys.cfg | cut -d: -f2)
	User=$(grep U: keys.cfg | cut -d: -f2)
  
fi

# POST a new scan 
curl --verbose 'https://cloud.tenable.com/scans' \
	-X POST \
	-H "X-Impersonate: username=$User" \
	-H "X-ApiKeys: accessKey=$aKey;secretKey=$sKey" \
	-H "Content-Type: application/json" \
	-d @${FileName}
echo
echo "Done..."



#!/bin/bash
aKey=12345678
sKey=abcdefgh

if [ $# -eq 0 ]; then
	echo -e "\nYou need to specify a JSON file with the scan configuration in it.\n"
	exit 99
else 
	FileName=${1}
fi

# POST a new scan 
curl --verbose 'https://cloud.tenable.com/scans' \
	-X POST \
	-H "X-Impersonate: username=jansuz@une.edu.au" \
	-H "X-ApiKeys: accessKey=$aKey;secretKey=$sKey" \
	-H "Content-Type: application/json" \
	-d @${FileName}
echo
echo "Done..."



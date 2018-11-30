#!/bin/bash
aKey=12345678
sKey=abcdefgh

# POST a new scan 
curl --verbose 'https://cloud.tenable.com/scans' \
	-X POST \
	-H "X-Impersonate: username=jansuz@une.edu.au" \
	-H "X-ApiKeys: accessKey=$aKey;secretKey=$sKey" \
	-H "Content-Type: application/json" \
	-d @ten_create_new_scan.json
echo
echo "Done..."



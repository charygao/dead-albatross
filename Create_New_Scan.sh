#!/bin/bash
aKey=12345678
sKey=abcdefgh

# Use the ten_folders_output.json to find the correct folder to put the scan into.
# {
#      "unread_count": 0,
#      "custom": 1,
#      "default_tag": 0,
#      "type": "custom",
#      "name": "FOLDERNAME",
#      "id": 154
#    },
Folder=$(echo $FileName | cut -d'_' -f2)
FolderID=$(grep $Folder -i -A1 ./ten_folders_output.json | sed 's/^[ \t]*//' | grep id)
FolderID=$(echo $FolderID | cut -d' ' -f2)

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



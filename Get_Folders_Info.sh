#!/bin/bash
aKey=$(grep A: keys.cfg | cut -d: -f2)
sKey=$(grep S: keys.cfg | cut -d: -f2)
User=$(grep U: keys.cfg | cut -d: -f2)
  

  curl -# -H "X-Impersonate: username=$User" \
    -H "X-ApiKeys: accessKey=$aKey; secretKey=$sKey" \
    https://cloud.tenable.com/folders | jq > ten_folders_output.json

echo
echo "Done..."

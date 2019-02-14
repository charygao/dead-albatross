#!/bin/bash
aKey=123
sKey=abc

  curl -# -H "X-Impersonate: username=elvis@preseley.com" \
    -H "X-ApiKeys: accessKey=$aKey; secretKey=$sKey" \
    https://cloud.tenable.com/folders | jq > ten_folders_output.json

echo
echo "Done..."

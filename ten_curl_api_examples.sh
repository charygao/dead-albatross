#!/bin/bash
aKey=12345678
sKey=abcdefgh

# Get Users
curl -H "X-Impersonate: username=elvis@presely.moc" -H "X-ApiKeys: accessKey=$aKey; secretKey=$sKey" \
  https://cloud.tenable.com/users --output ten_users.json

# Get Scans
curl -H "X-Impersonate: username=elvis@presely.moc" -H "X-ApiKeys: accessKey=$aKey; secretKey=$sKey" \
  https://cloud.tenable.com/scans --output ten_scans_output.json

# Get Scanners
curl -H "X-Impersonate: username=elvis@presely.moc" -H "X-ApiKeys: accessKey=$aKey; secretKey=$sKey" \
  https://cloud.tenable.com/scanners --output ten_scanners_output.json

# Get Folders
curl -H "X-Impersonate: username=elvis@presely.moc" -H "X-ApiKeys: accessKey=$aKey; secretKey=$sKey" \
  https://cloud.tenable.com/folders --output ten_folders_output.json

# Get Policy Templates
curl -H "X-Impersonate: username=elvis@presely.moc" -H "X-ApiKeys: accessKey=$aKey; secretKey=$sKey" \
  https://cloud.tenable.com/policies --output ten_policies_output.json

# Get Editor (Scan) Templates
curl -H "X-Impersonate: username=elvis@presely.moc" -H "X-ApiKeys: accessKey=$aKey; secretKey=$sKey" \
  https://cloud.tenable.com/editor/scan/templates --output ten_scan_templates.json



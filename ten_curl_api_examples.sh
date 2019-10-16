#!/bin/bash
aKey=$(grep A: keys.cfg | cut -d: -f2)
sKey=$(grep S: keys.cfg | cut -d: -f2)
User=$(grep U: keys.cfg | cut -d: -f2)

# Get Users
curl -H "X-Impersonate: username=$User" -H "X-ApiKeys: accessKey=$aKey; secretKey=$sKey" \
  https://cloud.tenable.com/users --output ten_users.json

cat ten_users.json | jq > $(basename ten_users.json json)txt
rm ten_users.json

# Get Scans
curl -H "X-Impersonate: username=$User" -H "X-ApiKeys: accessKey=$aKey; secretKey=$sKey" \
  https://cloud.tenable.com/scans --output ten_scans_output.json

cat ten_scans_output.json | jq > $(basename ten_scans_output.json json)txt
rm ten_scans_output.json

# Get Scanners
curl -H "X-Impersonate: username=$User" -H "X-ApiKeys: accessKey=$aKey; secretKey=$sKey" \
  https://cloud.tenable.com/scanners --output ten_scanners_output.json

cat ten_scanners_output.json | jq > $(basename ten_scanners_output.json json)txt
rm ten_scanners_output.json

# Get Folders
curl -H "X-Impersonate: username=$User" -H "X-ApiKeys: accessKey=$aKey; secretKey=$sKey" \
  https://cloud.tenable.com/folders --output ten_folders_output.json

cat ten_folders_output.json | jq > $(basename ten_folders_output.json json)txt
rm ten_folders_output.json

# Get Policy Templates
curl -H "X-Impersonate: username=$User" -H "X-ApiKeys: accessKey=$aKey; secretKey=$sKey" \
  https://cloud.tenable.com/policies --output ten_policies_output.json

cat ten_policies_output.json | jq > $(basename ten_policies_output.json json)txt
rm ten_policies_output.json

# Get Editor (Scan) Templates
curl -H "X-Impersonate: username=$User" -H "X-ApiKeys: accessKey=$aKey; secretKey=$sKey" \
  https://cloud.tenable.com/editor/scan/templates --output ten_scan_templates.json

cat ten_scan_templates.json | jq > $(basename ten_scan_templates.json json)txt
rm ten_scan_templates.json

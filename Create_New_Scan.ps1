# 
# Migrating script from bash to powershell.
# This script should create a new scan item in Tenable.IO
# K.I.S.S for future generations to understand.
#

# Declare Common Named Variables
$TAB = [char]9
$CR = [char]10
$QUOTE = [char]34

# Build Headers
$Headers=@{}
$Headers.Add("accept", "application/json")
$Headers.Add("content-type", "application/json")
# $Headers.Add("X-Impersonate", "username=elvis@mcdonalds.com")
$Headers.Add("X-ApiKeys", "accessKey=[redacted];secretKey=[redacted]")

# Build Body
$Body = "{"
$Body = $Body + $QUOTE + "UUID" + $QUOTE + ":" + $QUOTE + "[redacted]" + $QUOTE + ","
$Body = $Body + $QUOTE + "settings" + $QUOTE + ":"
# Settings Subsection
$Body = $Body + "{"
$Body = $Body + $QUOTE + "name" + $QUOTE + ":" + $QUOTE + "X" + $QUOTE + ","
$Body = $Body + $QUOTE + "description" + $QUOTE + ":" + $QUOTE + "Y" + $QUOTE + ","
$Body = $Body + $QUOTE + "policy_id" + $QUOTE + ":" + $QUOTE + "0" + $QUOTE + ","
$Body = $Body + $QUOTE + "folder_id" + $QUOTE + ":" + $QUOTE + "0" + $QUOTE + ","
$Body = $Body + $QUOTE + "scanner_uuid" + $QUOTE + ":" + $QUOTE + "0" + $QUOTE + ","
$Body = $Body + $QUOTE + "enabled" + $QUOTE + ":" + $QUOTE + "true" + $QUOTE + ","
$Body = $Body + $QUOTE + "launch" + $QUOTE + ":" + $QUOTE + "ON_DEMAND" + $QUOTE + ","
$Body = $Body + $QUOTE + "starttime" + $QUOTE + ":" + $QUOTE + "199801010001" + $QUOTE + ","
$Body = $Body + $QUOTE + "rrules" + $QUOTE + ":" + $QUOTE + "FREQ=ONETIME" + $QUOTE + ","
$Body = $Body + $QUOTE + "timezone" + $QUOTE + ":" + $QUOTE + "Australia/Sydney" + $QUOTE + ","
$Body = $Body + $QUOTE + "tag_targets" + $QUOTE + ":" + $QUOTE + "[redacted]" + $QUOTE + ","
$Body = $Body + $QUOTE + "emails" + $QUOTE + ":" + $QUOTE + "elvis@mcdonalds.com" + $QUOTE
$Body = $Body + "}"

# Close Body
$Body = -join($Body, "}");

write-output $Headers $CR $Body $CR

$response = Invoke-WebRequest -Uri 'https://cloud.tenable.com/scans' -Method POST -Headers $Headers -ContentType 'application/json' -Body '$Body'
write-output $response



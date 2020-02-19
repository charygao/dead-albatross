#
# Jolyon Ansuz
# January 2020
# Converting BASH scripts to Python for Tenable automation.
#
import requests
from test.test_mailbox import _sample_payloads
import uuid

# Build Variables, later to accept as external arguments.
#
kf="keys.cfg"
sf="labs.csv"
accessKey = ""
secretKey = ""
userEmulate = ""
url = "https://cloud.tenable.com/scans"
scanner_id="0"
enabled="TRUE"
launch=""
rrules="FREQ=ONETIME"
timezone="Australia/Sydney"
tag_targets="9ee29d57-7c1a-4e78-8e2a-ff6e598ade94"
tag_targets="00000000-00000000000000-000000000000"
emails="elvis@presely.moc,ronald@mcdonalds.com"
name=""
description=""

# Obtain AccessKey, SecretKey and User to emulate.
#
# Expected Fields
# A:{AccessKey}
# S:{SecretKey}
# U:{EmulatedUser_as_emailadddress}
# B:{Value)}
#
with open(kf) as KeyFile:
    for l in KeyFile:
        if l[:1].lower() == 'a'.lower():
            accessKey = l[-(len(l)-2):]
            accessKey = accessKey.rstrip()
        elif l[:1].lower() == 's'.lower():
            secretKey = l[-(len(l)-2):]
            secretKey = secretKey.rstrip()
        elif l[:1].lower() == 'u'.lower():
            userEmulate = l[-(len(l)-2):]
            userEmulate = userEmulate.rstrip()
        elif l[:1].lower() == 'b'.lower():
            pass
KeyFile.close

# Obtain ScanTime, ScanType, Network.
#
# Expected Fields
# 202004281715,scan,labs
# 202004290615,scan,fmsservices
# 202004300515,scan,qos
# ...
#
# PS. Further notes...
# ScanTime = yyyymmddhhMM, which will be formated appropriately.
# ScanType = Discovery or Scan (in this case), used to define the custom made policy I use for a
#            discovery scan or a basic host/network based scan.
# Labs = The network range I'm using, defined by Tenable Tags. This also defines the folder I place the scan in.
#
# A quick note on tags.
# Create groups of tags into one tag. Eg, A,B,C > All.
# This will make your life easier.

#
with open(sf) as ScheduleFile:
    for l in ScheduleFile:
        ScanTime = l.split(",")[0]
        ScanTime = ScanTime[:8] + "T" + ScanTime[-(len(ScanTime)-8):] + "00"
        ScanType = l.split(",")[1]
        ScanType = ScanType.lower()
        Network = l.split(",")[2]
        Network = Network.rstrip()
        Network = Network.lower()

        # Select Case Network.
        NetworkSwitch = {
            "trash":"8",
            "myscans":"9",
            "staff":"152",
            "deptsvrs":"153",
            "audiovisual":"154",
            "qos":"155",
            "mfd":"156",
            "labs":"157",
            "assessment":"158",
            "fmsservices":"160",
            "students":"203",
            "datacentre":"495"
        }
        folder_id = NetworkSwitch[Network]

        # Select Case Tag
        TagSwitch = {
            "staff":""00000000-0000-0000-0000-000000000000"",
            "deptsvrs":""00000000-0000-0000-0000-000000000000"",
            "audiovisual":""00000000-0000-0000-0000-000000000000"",
            # Ad Nauseum
        }
        tag_targets = TagSwitch[Network]

        # ScanTime
        starttime = ScanTime

        # Select Case ScanType
        ScanSwitch = {
            "discovery":"1",
            "scan":"2"
        }
        policy_id = ScanSwitch[ScanType]

        UUIDSwitch = {
            "discovery":""00000000-0000-0000-0000-000000000000"",
            "scan":""00000000-0000-0000-0000-000000000000""
        }
        uuid = UUIDSwitch[ScanType]

        # Define Name of Scan
        name = Network.capitalize() + " " + ScanType.capitalize() + " Scan, (" + starttime +")"
        # Describe the Scan
        description = ScanType.capitalize() + " scan of " + Network.capitalize() + " (Automatically Created)"

        #Build The Payload
        payload = "{"
        payload = payload + "\"uuid\":\"" + uuid + "\","
        payload = payload + "\"settings\":{"
        payload = payload + "\"name\":\"" + name + "\","
        payload = payload + "\"description\":\"" + description + "\","
        payload = payload + "\"policy_id\":\"" + policy_id + "\","
        payload = payload + "\"folder_id\":\"" + folder_id + "\","
        payload = payload + "\"scanner_id\":\"" + scanner_id + "\","
        payload = payload + "\"enabled\":\"" + enabled + "\","
        payload = payload + "\"launch\":\"" + launch + "\","
        payload = payload + "\"starttime\":\"" + starttime + "\","
        payload = payload + "\"rrules\":\"" + rrules + "\","
        payload = payload + "\"timezone\":\"" + timezone + "\","
        payload = payload + "\"tag_targets\":[\"" + tag_targets + "\"],"
        payload = payload + "\"emails\":\"" + emails + "\""
        payload = payload + "}"
        payload = payload + "}"

        # Build The Headers
        headers = {
            'accept': "application/json",
            'content-type': "application/json",
            'x-apikeys': "accessKey=" + accessKey + ";secretKey=" + secretKey
            }

        # Shot out
        response = requests.request("POST", url, data=payload, headers=headers)

        # Shot over
        print(response.text)
        print()

ScheduleFile.close

print("Done.")

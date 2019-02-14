#!/usr/local/bin/bash

#
# Need to read a file (eg. COMPANYNAME_VLANTOSCAN_SCANTYPE_Scan_Dates.csv) to create
# the JSON file used by scheduling script to COMPANYNAME_VLANTOSCAN_SCANTYPE-yyyyMMddmmss.json
#
# Someone should be able to then use the "Create_New_Scan.sh" script.
#

if [ $# -eq 0 ]; then
	echo -e "\nYou need to specify a CSV file with the scan dates in it.\nExample COMPANYNAME_VLANTOSCAN_SCANTYPE_Scan_Dates.csv\n"
	exit 99
else 
	FileName=${1}
fi

ScanName=$(basename -s _Dates.csv $FileName)

readarray -d, DateArray < $FileName

for i in "${DateArray[@]}"
	do 
		Day=$(echo ${i} | sed 's/,//g' | cut -c7-8 );
		Month=$(echo ${i} | sed 's/,//g' | cut -c5-6 );
		Year=$(echo ${i} | sed 's/,//g' | cut -c1-4 );
		Hour="11"
		Minute="12"
		ScanTime="${Year}${Month}${Day}${Hour}${Minute}"

		# Copy this into a file per scan, K.I.S.S. Let coders refine this, not admins.

		UUID="999-999-999"
		NewFileName=${ScanName}-"${Year}${Month}${Day}${Hour}${Minute}".json
		Description="This scan was configured using JSON and the tenable.IO API."
		Recipients="elvis@presely.com,ronald@mcdonalds.com"
		ScannerID="999"
		# ...and so on.

		echo "{" > $NewFileName
		echo -e "\"uuid\": \"${UUID}\"," >> $NewFileName
		echo -e "\t\"settings\": {" >> $NewFileName
		echo -e "\t\t\"name\": \"$ScanName\"," >> $NewFileName
		echo -e "\t\t\"description\": \"${Description}\"," >> $NewFileName
		echo -e "\t\t\"enabled\": \"false\"," >> $NewFileName
		echo -e "\t\t\"launch\": \"ON_DEMAND\"," >> $NewFileName
		echo -e "\t\t\"starttime\": \"${ScanTime}\"," >> $NewFileName
		echo -e "\t\t\"timezone\": \"Australia/Sydney\"," >> $NewFileName
		echo -e "\t\t\"rrules\": \"FREQ=ONETIME\"," >> $NewFileName
		echo -e "\t\t\"emails\": \"${Recipients}\"," >> $NewFileName
		echo -e "\t\t\"folder_id\": 9," >> $NewFileName
		echo -e "\t\t\"policy_id\": \"210\"," >> $NewFileName
		echo -e "\t\t\"scanner_id\": \"${ScannerID\"," >> $NewFileName
		echo -e "\t\t\"text_targets\": \"127.0.0.1\"" >> $NewFileName
		echo -e "\t}" >> $NewFileName
		echo -e "}" >> $NewFileName

		cat $NewFileName

	done

echo -e '\nDone.\n'

#!/usr/local/bin/bash
for l in $(grep Company ten_scan_dates.txt);
 do 
  Section=$(echo $l | cut -d, -f1)
  FileName=$(echo $l | cut -d, -f1)_Scan_Dates.csv
  rm $FileName
  echo $(echo $l | grep $Section | cut -d, -f2-99) > $FileName
 done

#!/bin/bash

clear
rm mdl_file_summary.csv

echo "Creating a summary file with input data from all .mdl files in current folder"
echo ""
echo ""
 #Headers
printf '%s\n' "File Name" "Joint Type" "Joint name" "Joint identifier" "body 1" "body 2" "point" "Direction" | paste -sd ',' >> mdl_file_summary.csv

for FILENAME in *.mdl
  do
    echo $FILENAME
    #Translational joint
    jt=$(grep 'TransJoint' $FILENAME | awk '{print $1}')
    jid=$(grep 'TransJoint' $FILENAME | awk '{print $2}')
    jname=$(grep 'TransJoint' $FILENAME | awk '{print $3}')
    b1=$(grep 'TransJoint' $FILENAME | awk '{print $4}')
    b2=$(grep 'TransJoint' $FILENAME | awk '{print $5}')    
    p1=$(grep 'TransJoint' $FILENAME | awk '{print $6}')    
    direction=$(grep 'TransJoint' $FILENAME | awk '{print $8}')    
    
    printf '%s\n' $FILENAME $jt $jid $jname $b1 $b2 $propShell $p1 $direction | paste -sd ',' >> mdl_file_summary.csv   
  done

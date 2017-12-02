#!/bin/bash

clear

if [ -e mdl_file_summary.txt ]
 then
    rm mdl_file_summary.txt
fi

#Replace spaces in file names with underscores
for f in *\ *; do mv "$f" "${f// /_}"; done

echo "Creating a summary file with input data from all .mdl files in current folder"
echo ""
echo ""
 #Headers
#printf '%s ' "File Name" "Joint Type" "Number">> mdl_file_summary.txt

for FILENAME in *.mdl
  do
    echo $FILENAME
    #Count the number of joints
    nTrans=$(grep -o 'TransJoint' $FILENAME | wc -l)
    nRev=$(grep -o 'RevJoint' $FILENAME | wc -l)
    nFixed=$(grep -o 'FixedJoint' $FILENAME | wc -l)
    nBall=$(grep -o 'BallJoint' $FILENAME | wc -l)
    
    nMotion=$(grep -o 'SetMotion' $FILENAME | wc -l)
    motionOnJoint=$(grep "*Motion" $FILENAME | awk '{print $6}')
    motionType=$(grep "SetMotion" $FILENAME | awk '{print $2}')
    motionType=$(grep "SetMotion" $FILENAME | awk '{print $3}')
    motionExp=$(grep "SetMotion" $FILENAME | awk '{print $5}')
    #echo $nTrans
    #Translational joint
    connTrans=($(grep 'TransJoint' $FILENAME))
    connRev=($(grep 'RevJoint' $FILENAME))    
    connFixed=($(grep 'FixedJoint' $FILENAME))    
    connBall=($(grep 'BallJoint' $FILENAME))    
    #jt=$(grep 'TransJoint' $FILENAME | awk '{print $1}')
    #jid=$(grep 'TransJoint' $FILENAME | awk '{print $2}')
    #jname=$(grep 'TransJoint' $FILENAME | awk '{print $3}')
    #b1=$(grep 'TransJoint' $FILENAME | awk '{print $4}')
    #b2=$(grep 'TransJoint' $FILENAME | awk '{print $5}')  
    #p1=$(grep 'TransJoint' $FILENAME | awk '{print $6}')    
    #direction=$(grep 'TransJoint' $FILENAME | awk '{print $8}')    
    
    printf '%s\n ' "------------------------------------" >> mdl_file_summary.txt
    printf '%s\n ' $FILENAME "--------------------------------" >> mdl_file_summary.txt
    printf '%s ' "Number of Translational Joints:" $nTrans "," "Number of Revolute Joints: " $nRev "," "Number of Fixed Joints: " $nFixed "," "Number of Ball Joints:" $nBall "," "Number of Motions:" $nMotion "," "Motion applied to:" $motionOnJoint "Motion type: "$motionType "," "Expression:"$motionExp >> mdl_file_summary.txt   
    echo $'\n' >> mdl_file_summary.txt
    printf '%s\n' "Translational Joint" ${connTrans[@]} " " " " >> mdl_file_summary.txt
    echo $'\n' >> mdl_file_summary.txt
    printf '%s\n'  "Revolute Joint" ${connRev[@]}  " " " " >> mdl_file_summary.txt
    echo $'\n' >> mdl_file_summary.txt
    printf '%s\n' "Fixed Joint" ${connFixed[@]} " " " " >> mdl_file_summary.txt
    echo $'\n' >> mdl_file_summary.txt     
    printf '%s\n' "Ball Joint" ${connBall[@]} " " " " >> mdl_file_summary.txt
    echo $'\n' >> mdl_file_summary.txt
    echo $'**********************************************************************\n' >> mdl_file_summary.txt         
  done
  
 #$jid $jname $b1 $b2 $propShell $p1 $direction

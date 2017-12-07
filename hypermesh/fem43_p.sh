#!/bin/bash

#'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''#
#Bash script reads all .fem files in current folder and creates
#a .text file with pertinent information
#
#Key portions of the code are:
#
#Author: Aneet Narendranath, PhD
#Date: 07-12-2017
#Version: 4.3
#
#'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''#


clear
rm input_file_summary.txt

echo "Creating a summary file with input data from all .fem files in current folder"
echo ""
echo ""
 #Headers
#printf '%s\n' "File Name" "Number of TET elements" "SPC data" "Property" "Young's modulus" "Poisson's ratio" "F_x Total" "F_y Total" "F_z total"| paste -sd ',' >> input_file_summary.csv

funcProcessing () { 

echo $FILENAME
    read first last <<< $(grep -n CTETRA $FILENAME | awk -F: 'NR==1 {printf "%d ", $1}; END{print $1}')
    #echo $((last-first))
    nElemTet=$((last-first)) 
#    if [ "$nElemeTet" = "0" ]; then
#       nElemError='Error in element type'
#    fi  
    
    #SPC DATA.  This needs to be treated as an array.
    spcVal=($(awk '$1 == "SPC" { print $4 }' $FILENAME))  
    #spcData=echo ${val}
    
    
    #PROPERTY CARD DATA
    propSolid=$(awk '$1 == "PSOLID" { print $1 }' $FILENAME)
    propLSolid=$(awk '$1 == "PLSOLID" { print $1 }' $FILENAME)
    propShell=$(awk '$1 == "PSHELL" { print $1 }' $FILENAME)
    
    #Bar elements need to be treated as an array. 
    propBar=($(awk '$1 == "CBAR" { print $1 }' $FILENAME ))
    
    #MATERIAL PROPERTY DATA
    Ey2=$(awk '$1 == "MAT1" { print $2 }' $FILENAME)
    Ey="${Ey2:1:${#Ey2}-2}"
    nu=$(awk '$1 == "MAT1" { print $3 }' $FILENAME)
    
    #USER OF RBE3?
    rbeString=$(grep 'RBE3' $FILENAME | awk '{print $1}' | tail -1)
    if [ "$rbeString" == "RBE3" ]; then
      flag=yes
    else
      flag=no
    fi
    #echo $flag #debugging purpose print

    
    #FORCE DATA
    nForceNodes0=$(grep 'FORCE' $FILENAME | awk '{print $5}' | wc -l)
    nForceNodes=$(($nForceNodes0-1))
    fx=$(grep 'FORCE' $FILENAME | awk '{print $5}' | awk '{ T+=$1 } END { print T }')
    fy=$(grep 'FORCE' $FILENAME | awk '{print $6}' | awk '{ T+=$1 } END { print T }')
    fz=$(grep 'FORCE' $FILENAME | awk '{print $7}' | awk '{ T+=$1 } END { print T }')
    

    #echo $nElem
    #echo $propCard
    #echo $Ey
    #echo $nu   
    
    printf '%s\n ' "-------------------------------------------------------------------------" >> input_file_summary.txt
    printf '%s\n ' $FILENAME "------------------------------------------------------------------------" >> input_file_summary.txt
    printf '%s' "Number of TET elements: " $nElemTet ", " >> input_file_summary.txt
    printf '%s\n ' >> input_file_summary.txt
    printf '%s' "Property flag: " $propSolid $propLSolid $propShell $probBar ", " >> input_file_summary.txt 
    printf '%s\n ' >> input_file_summary.txt
    printf '%s ' "Young's mod: "  $Ey ", " "Poisson's ratio: " $nu ", " >> input_file_summary.txt
    printf '%s\n ' >> input_file_summary.txt
    printf "%s" "SPC: " ${spcVal} ", " >> input_file_summary.txt   
    printf '%s\n ' >> input_file_summary.txt 
    printf '%s' "Total force (sum in each direction), X Y Z: " $fx ", " $fy ", " $fz | paste -sd ',' >> input_file_summary.txt
    printf '%s\n ' >> input_file_summary.txt
    printf "%s" "Use of RBE3? " $flag >>input_file_summary.txt
    printf '%s\n ' >> input_file_summary.txt
    echo $'**********************************************************************\n\n' >> input_file_summary.txt


}

for FILENAME in $( ls *.fem); do
    funcProcessing &
done
wait 

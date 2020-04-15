#!/bin/bash

#'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''#
#Bash script reads all .fem files in current folder and creates
#a .csv file with pertinent information
#
#Key portions of the code are:
#
#Author: Aneet Narendranath, PhD
#Date: 13-04-2020
#Version: 3.0
#
#'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''#

RED='\033[0;31m'
CYAN = '\033[0;36m'
NC='\033[0m' # No Color


clear
#rm input_file_summary.txt
rm *.csv

figlet -c Hypermesh Input File Summarizer #-f digital

sleep 3

#clear 

echo -e "In this demonstration version, names of students have been obscured through abbreviation to protect their privacy\n\n"
echo -e "Creation of ${RED}Summary-file of student simulations${NC} will start in 3 seconds"
echo ""
echo ""

sleep 3 
echo -e "\n Please wait while script is in progress\n"
 #Headers
#printf '%s\n' "File Name" "Number of TET elements" "SPC data" "Property" "Young's modulus" "Poisson's ratio" "F_x Total" "F_y Total" "F_z total"| paste -sd ',' >> input_file_summary.csv

for FILENAME in *.fem
  do
    #echo $FILENAME
	echo -n "##"
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
    printf '%s\n' $FILENAME $nElemTet $propSolid $propLSolid $propShell $probBar $Ey ${spcVal} $fx $fy $fz $flag | paste -sd ',' >> results.csv

  done
    echo ""
	sleep 0.5
	#clear
    echo -e "\n\nStudent simulations have now been summarized in ${RED}'results.csv'${NC}\n\n"
	sleep 0.3
	printf "Here is a sneak peak of the summary:\n"
	echo -e "\n file name, elements, property, Ey, SPC use, fx, fy, fz, rbe3 use\n"
	echo -e "------------------------------------------------------------------\n"
	head -5 results.csv
	sleep 1
    echo -e "\n\n\n"
	echo -e "Please make sure to collect ${RED}'results.csv'${NC}\n\n\n"
#eof

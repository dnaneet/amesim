#!/bin/bash

clear
rm input_file_summary.csv

echo "Creating a summary file with input data from all .fem files in current folder"
echo ""
echo ""
 #Headers
printf '%s\n' "File Name" "Number of TET elements" "SPC data" "Property" "Young's modulus" "Poisson's ratio" | paste -sd ',' >> input_file_summary.csv

for FILENAME in *.fem
  do
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
    Ey=$(awk '$1 == "MAT1" { print $2 }' $FILENAME)
    nu=$(awk '$1 == "MAT1" { print $3 }' $FILENAME)
    
    #echo $nElem
    #echo $propCard
    #echo $Ey
    #echo $nu   
    
    printf '%s\n' $FILENAME $nElemTet ${spcVal} $propSolid $propLSolid $propShell $probBar $Ey $nu | paste -sd ',' >> input_file_summary.csv

  done
    echo ""
    echo "Collection of input data from all .fem files in the current folder is now complete!"
    #eof

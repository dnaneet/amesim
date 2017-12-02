#!/bin/bash

clear

if [ -e files_submitted.csv ]
 then
    rm files_submitted.csv
fi

echo "Creating a summary file details of submission per student who submitted any file"
echo ""
echo ""
printf '%s\n' "File Name" ".fem file submitted?" ".h3d file submitted?" ".out file submitted?" ".stat file submitted?" | paste -sd ',' >> files_submitted.csv

for FILENAME in *
    do
        #Check for .fem files
        if [ ${FILENAME: -4} == ".fem" ]
	    then
            fem=yes
        else
            fem=no  
        fi     
         
        #Check for .h3d files  
        if [ ${FILENAME: -4} == ".h3d" ]
	    then
            h3d=yes
        else
            h3d=no    
        fi
        
        
        if [ ${FILENAME: -4} == ".out" ]
	    then
            out=yes
        else
            out=no    
        fi	
            
        if [ ${FILENAME: -4} == ".stat" ]
	    then
            stat=yes
        else
            stat=no    
        fi	                	
	printf '%s\n' $FILENAME $fem $h3d $out $stat | paste -sd ',' >> files_submitted.csv	
    done
echo "Completed analysis"


#eof        

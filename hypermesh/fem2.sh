#!/bin/bash

rm results.csv

for FILENAME in *.out *.fem;
  do
    	#Number of CTETRA elements
    	nElem=$(awk '$1 == "CTETRA" { print $4 }' $FILENAME)
    
    	#Material and property information
    	forceCard=$(awk '$1 == "FORCE" { print $4 }' $FILENAME)
    	spcCard=$(awk '$1 == "SPC" { print $4 }' $FILENAME)
    	propCard=$(awk '$1 == "PSOLID" { print $1 }' $FILENAME)
    	propCard2=$(awk '$1 == "PLSOLID" { print $1 }' $FILENAME)
    	propCard3=$(awk '$1 == "PSHELL" { print $1 }' $FILENAME)
        matCard=$(awk '$1 == "MAT1" { print $4 }' $FILENAME)
        
        #Strain energy residual.  If small and comparable to machine precision, then 
        #high likelihood that the solution has converged.
        eps=$(sed -n '/Compliance     Epsilon/,+2p' $FILENAME)
	#Run type identification
	#rType=$(sed -n '/OPTIMIZATION/,+10p' Part3.out)
	#PRINT VALUES TO SCREEN
	#echo $nElem
	#echo $forceCard
	#echo $spcCard
	#echo $propCard
	#echo $propCard2 #For PLSOLID
	#echo $propCard3 #For PSHELL
	#echo $matCard
	#echo $eps
	printf '%s\n' $FILENAME $nElem $spcCard $forceCard $matCard $propCard $propCard2 $propCard4 | paste -sd ',' >> results.csv
  done

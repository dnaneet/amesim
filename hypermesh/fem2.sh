#!/bin/bash


for FILENAME in *.out
  do
    	#Number of CTETRA elements
    	nElem=$(awk '$1 == "CTETRA" { print $4 }' $FILENAME)
    
    	#Material and property information
    	propCard=$(awk '$1 == "PSOLID" { print $1 }' $FILENAME)
        matCard=$(awk '$1 == "MAT1" { print $4 }' $FILENAME)
        eps=$(sed -n '/Epsilon/,+2p' $FILENAME)
	#Run type identification
	#rType=$(sed -n '/OPTIMIZATION/,+10p' Part3.out)
	#PRINT VALUES TO SCREEN
	echo $nElem
	echo $propCard
	echo $matCard
	echo $eps
  done

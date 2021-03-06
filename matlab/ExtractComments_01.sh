#!/bin/bash
#''''''''''''''''''''''''''''''''''''''#
# Bash script that runs all MATLAB     # 
# script in a folder and saves outputs # 
# with the same name as base MATLAB    # 
# script.                              #
#				       #
# Aneet Narendranath, PhD (c) 2018     #
#''''''''''''''''''''''''''''''''''''''#

echo "Creating a summary file with code comments, itemized by student"
echo ""
echo ""
echo "Removing comments.csv"
clear
for FILE in *.m
  do
#    printf '%s\n' $FILE | paste -sd ',' >> comments.csv
	while read -r line; do
#    		name="$line" #THIS LINE FOR DEBUGGING
#    		echo $line #THIS LINE FOR DEBUGGING ONLY		
		inlineComment=$(awk -F' %' '{print $2}' $line)  #Extract inline comments
		printf '%s\n' $inlineComment | paste -sd ',' >> comments.csv
	done < $FILE
#    inlineComment=$(awk -F' %' '{print $2}' $FILE)  #Extract inline comments
#    echo $inlineComment
#    printf '%s\n' $inlineComment | paste -sd ',' >> comments.csv
#    grep '^%' $FILE #Extract comment blocks
  done


#eof

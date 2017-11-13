#!/bin/bash


for FILENAME in *.ame
  do
    #echo $i #Debugging purpose
    master_file="master.ame"
    #echo $master_file #Debugging purpose
    master_size=$(echo $(du -k "$master_file" | cut -f1))	 
    #echo $master_size #debugging purpose
    #file_size=$(du -k "$i" | cut -f1)  
    #echo $file_size
    #echo $((master_size-1)) #Subtraction #Debugging purpose
    file_size=$(du -k "$FILENAME" | cut -f1)
    #echo $file_size
    difference=$(($file_size - $master_size))
    #echo $(du -k "$FILENAME" | cut -f1) #Debugging purpose
    printf '%s\n' $FILENAME $(du -k "$FILENAME" | cut -f1) $difference | paste -sd ',' >> sizes.csv
  done

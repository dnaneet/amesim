#!/bin/bash
#''''''''''''''''''''''''''''''''''''''#
# Bash script that runs all MATLAB     # 
# script in a folder and saves outputs # 
# with the same name as base MATLAB    # 
# script.                              #
#				       #
# Aneet Narendranath, PhD (c) 2018     #
#''''''''''''''''''''''''''''''''''''''#

echo "Creating a summary file with input data from all .fem files in current folder"
echo ""
echo ""

for FILE in *.m
  do
    #echo $FILE
   if [ "$FILE" != "xsteam.m" ]; then
      #echo $FILE #Debug 
      #outFile=$(ls *.m -t | head -n1)
      #/home/dnaneet/MATLAB/R2016b/bin/./matlab -nodesktop -nodisplay -nosplash -nojvm -r "$FILE ; exit"
      echo "${FILE%%.*}"
     /home/dnaneet/MATLAB/R2016b/bin/./matlab -nodesktop -nodisplay -nosplash -r "${FILE%%.*} ; exit"
     mv "W_dot.txt" ${FILE%%.*}.txt
   fi
  done

#eof

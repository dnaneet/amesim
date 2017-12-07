#!/bin/bash
#''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
#Checks within each .zip file in current folder
#for the presence of a .fem or .mdl file
#
#When a .fem or .mdl file is found, it extracts the latest version of it into
# ./femfiles or ./mdlfiles AND renames these extracted .fem or .mdl files with
#the same name as the original zip file.
#
# Author: Aneet Narendranath, PhD
# Ver 2.0 / 7-Dec-2017
#
#''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

for i in *.zip;
    do
        fem_exists=$(zipinfo $i | grep "fem" | wc -l)
        mdl_exists=$(zipinfo $i | grep "mdl" | wc -l)
        if [ $fem_exists != 0 ]
            then 
                #echo true
                path_to_file=($(zipinfo $i | grep "fem" | awk '{print $9}'))  
                #echo $path_to_file    
                new_name_0=$i
                #echo $new_name_0
                new_name=$(echo "${new_name_0%.*}")
                #echo $new_name
                unzip -o -qq $i #Unzip while overwriting (-o), al done very quietly (-qq)
                mv $path_to_file ./femfiles/$new_name
        elif [ $mdl_exists != 0 ]
            then
                #echo true
                path_to_file=($(zipinfo $i | grep "mdl" | awk '{print $9}'))  
                #echo $path_to_file    
                new_name_0=$i
                #echo $new_name_0
                new_name=$(echo "${new_name_0%.*}")
                #echo $new_name
                unzip -o -qq $i #Unzip while overwriting (-o), al done very quietly (-qq)
                mv $path_to_file ./mdlfiles/$new_name
        fi
    done

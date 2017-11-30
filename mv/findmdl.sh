#!/bin/bash

for FILENAME in ./
  do
   #echo $(find ./ -type f -name "*.mdl") #Echo is only for debugging purposes
   find ./ -type f -name "*.mdl" -exec cp {} ./mdlfiles/ \;
  done


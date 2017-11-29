#!/bin/bash

rbeString=$(grep 'RBE3' Part3.fem | awk '{print $1}' | tail -1)

if [ "$rbeString" == "RBE3" ]; then
  flag=1
else
  flag=0  
fi
echo $flag


#!/bin/bash

 for FILENAME in *.fem
  do
    #FORCE DATA
    nForceNodes0=$(grep 'FORCE' $FILENAME | awk '{print $5}' | wc -l)
    echo $(($nForceNodes0-1))
    #nForceNodes = $(($nForceNodes0 - 1))
    fx=$(grep 'FORCE' $FILENAME | awk '{print $5}' | awk '{ T+=$1 } END { print T }')
    #fy=$(grep 'FORCE' Part3.fem | awk '{print $5}' | awk '{ T+=$1 } END { print T }')
    #fz=$(grep 'FORCE' Part3.fem | awk '{print $7}' | awk '{ T+=$1 } END { print T }')
  done


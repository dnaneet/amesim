#!/bin/bash

for FILENAME in *.fem
  do
    echo $FILENAME
    read first last <<< $(grep -n CTETRA $FILENAME | awk -F: 'NR==1 {printf "%d ", $1}; END{print $1}')
    echo $((last-first))
  done


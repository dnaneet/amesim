#!/bin/bash

while read number;do
    start=$(grep "TransJoint" cart_w_wheels_v01_07312017b_avec_bushings.mdl\
            |head -n 1|awk '{print $2}')
    end=$(grep -A 1 "Batch $number was successful" log_file\
            |head -n 2|tail -n 1|awk -v OFS=',' '{print $2,$6}')
    echo "$number,$start,$end Secs"
done <cart_w_wheels_v01_07312017b_avec_bushings.mdl

#!/bin/bash

# $1: i
# $2: max_j
# $3: prefix
_helper() {
    for ((j = 0; j < $2; j++)); do
	   sudo echo "i:$1,j:$j" > /mnt/ramdisk/alluxioworker/f_${3}_${1}_${j}
    done
}

>/tmp/stats
for ((i = 0; i < $1; i++)); do
    export TIMEFORMAT='%3R %3U %3S'
    if [[ $4 = "-t" ]]; then
        sudo mkdir -p /mnt/ramdisk/alluxioworker/$i
    fi
    time ( _helper $i $2 $3 ) &>> /tmp/stats 
done


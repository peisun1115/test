#!/bin/bash

# $1: i
# $2: max_j
# $3: prefix
# $4: dir
_helper() {
    for ((j = 0; j < $2; j++)); do
	   echo "i:$1,j:$j" > ${4}/f_${3}_${1}_${j}
    done
}

>/tmp/stats
DIR="/mnt/ramdisk/alluxioworker"
export TIMEFORMAT='%3R %3U %3S'
for ((i = 0; i < $1; i++)); do
    if [[ $4 = "-t" ]]; then
        mkdir -p ${DIR}/$i
        DIR="${DIR}/$i"
    fi
    time ( _helper $i $2 $3 ${DIR}) &>> /tmp/stats 
done


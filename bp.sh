#!/bin/bash

# $1: i
# $2: max_j
# $3: prefix
# $4: dir
_helper() {
    for ((j = 0; j < $2; j++)); do
	   echo "i:j:i:j" > ${4}/f_${3}_${1}_${j}
    done
}

>/tmp/stats
DIR="/mnt/ramdisk/alluxioworker"
sudo chmod a+w ${DIR}
sudo chmod a+w /mnt/ramdisk
sudo rm -rf ${DIR}/*
export TIMEFORMAT='%3R %3U %3S'
for ((i = 0; i < $1; i++)); do
    if [[ $4 = "-t" ]]; then
        sudo mkdir -p ${DIR}/$i
        DIR="${DIR}/$i"
    fi
    sudo chmod a+w ${DIR}
    time ( _helper $i $2 $3 ${DIR}) &>> /tmp/stats 
done


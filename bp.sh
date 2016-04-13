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

DIR=$1
sudo chmod a+w "${DIR}"
DIR="${DIR}/alluxioworker"
sudo mkdir -p "${DIR}"
sudo rm -rf ${DIR}/*
shift

export TIMEFORMAT='%3R %3U %3S'
for ((i = 0; i < $1; i++)); do
    if [[ $4 = "-t" ]]; then
        sudo mkdir -p ${DIR}/$i
        DIR="${DIR}/$i"
    fi
    sudo chmod a+w ${DIR}
    time ( _helper $i $2 $3 ${DIR} ) &>> /tmp/stats 
done


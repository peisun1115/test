#!/bin/bash

# Usage: bp.sh ACTION DIR U1 U2 OUTPUT [-t]
# ACTION: ALLUXIO -> Use alluxio shell.
# ACTION: LOCAL -> Write locally. 
# 
# DIR: the directory to write data to.
# 
# U1: the outter limit.
# U2: the inner limit.
#
# OUTPUT: the output filename
#
# F: File prefix.
#
# -t: Create a new directory for each U2.

ACTION=$1
if [[ ${ACTION} = "SETUP" ]]; then
    sudo mkdir -p "/mnt/ramdisk"
    sudo mount -t ramfs -o size=$((1024*1024*1024*4)) ramfs "/mnt/ramdisk"
    sudo chmod a+w "/mnt/ramdisk"
    exit 0
fi

DIR=$2
U1=$3
U2=$4
OUTPUT=$5
F=$6
T=$7

>"${OUTPUT}"

export TIMEFORMAT='%3R %3U %3S'
export ALLUXIO_BIN="../alluxio/bin/alluxio"

# $1: i
_local_write() {
    local D="${DIR}"
    if [[ ${T} = "-t" ]]; then
        sudo mkdir -p "${DIR}/$1"
        D="${D}/$1"
    fi

    for ((j = 0; j < ${U2}; j++)); do
	echo 'a' > ${D}/f_${F}_${1}_${j}
    done
}

_alluxio_write() {
    local D="${DIR}"
    if [[ ${T} = "-t" ]]; then
        "${ALLUXIO_BIN}" "fs" "mkdir" "${DIR}/$1"
        D="${D}/$1"
    fi

    for ((j = 0; j < ${U2}; j++)); do
        "${ALLUXIO_BIN}" "fs" "copyFromLocal" "./golden" "${D}/f_${F}_${1}_${j}" &> /dev/null
    done
}

for ((i = 0; i < ${U1}; i++)); do
    case ${ACTION} in
        "ALLUXIO")
            time ( _alluxio_write $i ) &>> ${OUTPUT}
            ;;
        "LOCAL")
            time ( _local_write $i ) &>> ${OUTPUT}
            ;;
        *)
            echo "Unsupported action."
            exit 1
            ;;
    esac
done



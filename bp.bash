#!/bin/bash

# Usage: bp.sh ACTION DIR U1 U2 COMMAND_TIMING JAVA_TIMING [-t]
# ACTION: ALLUXIO -> Use alluxio shell.
# ACTION: LOCAL -> Write locally. 
# 
# DIR: the directory to write data to.
# 
# U1: the outter limit.
# U2: the inner limit.
#
# COMMAND_TIMING: the output filename that contains timing information from commandline (time).
# JAVA_TIMING: the output filename that contains timing information from Java.
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

COMMAND_TIMING=$5
JAVA_TIMING=$6

F=$7
T=$8

export TIMEFORMAT='%3R %3U %3S'
export ALLUXIO_BIN="${HOME}/workspace/alluxio/bin/alluxio"

ALLUXIO_FILE_SIZE=${ALLUXIO_FILE_SIZE:-4096}

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
    ${ALLUXIO_BIN} "fs" "write" "${D}/f_${F}_${1}" "${ALLUXIO_FILE_SIZE}" "${U2}" >> "${JAVA_TIMING}" 
}

for ((i = 0; i < ${U1}; i++)); do
    case ${ACTION} in
        "ALLUXIO")
            time ( _alluxio_write $i ) >> ${COMMAND_TIMING}
            ;;
        "LOCAL")
            time ( _local_write $i ) >> ${COMMAND_TIMING}
            ;;
        *)
            echo "Unsupported action."
            exit 1
            ;;
    esac
done



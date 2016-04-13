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
# -t: Create a new directory for each U2.

ACTION=$1
DIR=$2
U1=$3
U2=$4
OUTPUT=$5
T=$6

>"${OUTPUT}"

export TIMEFORMAT='%3R %3U %3S'
export ALLUXIO_BIN="../alluxio/bin/alluxio fs "

# $1: i
_local_write() {
    local D="${DIR}"
    if [[ ${T} = "-t" ]]; then
        sudo mkdir -p "${DIR}/$1"
        D="${D}/$1"
    fi

    for ((j = 0; j < ${U2}; j++)); do
        cp ./golden ${D}/f_${1}_${j}
    done
}

_alluxio_write() {
    local D="${DIR}"
    if [[ ${T} = "-t" ]]; then
        "${ALLUXIO_BIN}" "mkdir" "${DIR}/$1"
        D="${D}/$1"
    fi

    for ((j = 0; j < $2; j++)); do
        "${ALLUXIO_BIN}" "copyFromLocal" "./golden" "${D}/f_${1}_${j}"
    done
}


for ((i = 0; i < ${U1}; i++)); do
    case ${ACTION} in
        "ALLUXIO")
            time ( _alluxio_write ) &>> ${OUTPUT}
            ;;
        "LOCAL")
            time ( _local_write ) &>> ${OUTPUT}
            ;;
        *)
            echo "Unsupported action."
            exit 1
            ;;
    esac
done



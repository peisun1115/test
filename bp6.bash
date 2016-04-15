#!/bin/bash

# Alluxio dir.
A=$1
# Output dir. O/java_timing, O/command_timging, O/machine_info. 
O=$2

OJ="${O}/java_timing"
OC="${O}/command_timing"
OM="${O}/machine_info"
BIN="./bp.bash"
FILE_PREFIX=0

_touch_files() {
    > ${OJ}
    > ${OC}
    > ${OM}
}

# Write $1 to all the output files as a separator.
_write_msg() {
    echo -ne "$1" >> ${OM}
    echo -ne "$1" >> ${OC}
    echo -ne "$1" >> ${OJ}
}

# $1: message to be written before dumping.
_dump_machine_info() {
    cat /proc/memeinfo >> "${OM}"
    echo "${OM}"
}

_restart_alluxio() {
    ${A}/bin/alluxio bootstrap-conf localhost
    export ALLUXIO_WORKER_MEMORY_SIZE=20G
    ${A}/bin/alluxio format
    ${A}/bin/alluxio-start.sh local
}

_inc() {
    FILE_PREFIX=$((${FILE_PREFIX}+1))
}

_set_size() {
    export ALLUXIO_FILE_SIZE=$1
}

main() {
    FILE_PREFIX=0

    _touch_files
  
    # Start.  Dump machine information to prepare all experiments.
    echo -e "#############STARTING POINT#############" >> ${OM}
    _dump_machine_info
  
    # Experiment 1. 
    # Write
    MSG="############# EXP1 ############
    Write 4*1000 files in Java, each one has size 4K.
    Write a file with size = 40M in Java.
    Write 4*1000 files in Java.
    ################################\n"
    _write_msg "${MSG}"
    
    _dump_machine_info
    _restart_alluxio 

    _write_msg "\nwrite 4*1K files (size=4KB)\n"
    _set_size 4096
    ${BIN} ALLUXIO "Alluxio:" 4 1000 ${OC} ${OJ} ${FILE_PREFIX}
    _inc
    _dump_machine_info

    _write_msg "\nwrite 1 file (size=40MB)\n"
    _set_size $((40*1024*1024))
    ${BIN} ALLUXIO "Alluxio:" 1 1 ${OC} ${OJ} ${FILE_PREFIX}
    _inc
    _dump_machine_info

    _write_msg "\nwrite 4*1K files (size=4KB)\n"
    _set_size 4096
    ${BIN} ALLUXIO "Alluxio:" 4 1000 ${OC} ${OJ} ${FILE_PREFIX}
    _inc
}

main "$@"

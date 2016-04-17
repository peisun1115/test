#!/bin/bash

# Alluxio dir.
A="${HOME}/workspace/alluxio"
# Output dir. O/java_timing, O/command_timging, O/machine_info. 
O="."

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
    echo -e "$1" >> ${OM}
    echo -e "$1" >> ${OC}
    echo -e "$1" >> ${OJ}
}

# $1: message to be written before dumping.
_dump_machine_info() {
    cat /proc/meminfo >> "${OM}"
    echo >> "${OM}"
}

_restart_alluxio() {
    ${A}/bin/alluxio bootstrap-conf localhost
    export ALLUXIO_WORKER_MEMORY_SIZE=$((20*1024*1024*1024)) # 20G
    ${A}/bin/alluxio-stop.sh all
    ${A}/bin/alluxio format
    ${A}/bin/alluxio-start.sh local
}

_inc() {
    FILE_PREFIX=$((${FILE_PREFIX}+1))
}

_set_size() {
    export ALLUXIO_FILE_SIZE=$1
}

_build() {
    mvn -Pdeveloper -T 2C clean install -Dmaven.javadoc.skip=true \
        -DskipTests -Dlicense.skip=true -Dcheckstyle.skip=true \
        -Dfindbugs.skip=true
 
}

_set_block_size() {
    local CURRENT_D=$( pwd )
    cd "${A}/core/common/src/main/resources"
    cp "alluxio-default.properties" "alluxio-default.properties.backup"
    cat "alluxio-default.properties.backup" | \
        sed "s/alluxio.user.block.size.bytes.default=512MB/alluxio.user.block.size.bytes.default=${1}/" |
        sed "s/alluxio.user.file.buffer.bytes=1MB/alluxio.user.file.buffer.bytes=${1}/"> \
        "alluxio-default.properties"
    cd "${A}"
    _build
    cd ${CURRENT_D}
}

_reset_block_size() {
    local CURRENT_D=$( pwd )
    cd "${A}/core/common/src/main/resources"
    mv "alluxio-default.properties.backup" "alluxio-default.properties"
    cd ${A}
    _build
    cd ${CURRENT_D}
}

# 1: batches
# 2: batch size
# 3: file size
_sub_exp() {
    _write_msg "\n\nwrite $1*$2 files (size=$(($3/1024))KB)\n"
    _set_size $3
    ${BIN} ALLUXIO "Alluxio:" $1 $2 ${OC} ${OJ} ${FILE_PREFIX}
    _inc
    _dump_machine_info
}


reset() {
    FILE_PREFIX=0
    _touch_files
    
    # Start.  Dump machine information to prepare all experiments.
    echo -e "#############STARTING POINT#############" >> ${OM}
    _dump_machine_info
}

exp1() {
    # Experiment 1. 
    MSG="/n/n############# EXP1: Test Large File ############
    Write 4*1000 files in Java, each one has size 4K.
    Write a file with size = 40M in Java.
    Write 4*1000 files in Java.
    Write a file with size = 1G in Java.
    Write 4*1000 files in Java.\n################################\n"
    _write_msg "${MSG}"
    _dump_machine_info
    _restart_alluxio 

    _sub_exp 4 1000 $((4*1024))
    _sub_exp 1 1 $((40*1024*1024))
    _sub_exp 4 1000 $((4*1024))
    _sub_exp 1 1 $((1*1024*1024*1024))
    _sub_exp 4 1000 $((4*1024))
}

exp2() {
    # Experiment 2.
    MSG="/n/n########### EXP2 Test Large number of small files.  ############
    Write 20 * 10K files in Java, each one has size of 4K (200K blocks in total).\n###############################\n"
    _write_msg "${MSG}"
    _dump_machine_info
    _restart_alluxio

    _sub_exp 20 10000 $((4*1024))
}

exp3() {
 # Experiment 3.
    MSG="\n\n########### EXP3 Test Large number of blocks. #############
    Set block size to be 4K.
    Write 8*1000 files in Java (to warm up Alluxio), each one has size 4K.
    Repeat the following 10 times.
      Write 16*1 file with size=4M (=> 16*4M/4K=16K blocks).
      Write 4*1000 files, size = 4K
    Reset block size to the default (512M) \n########################################\n"
    _write_msg "${MSG}"
    _dump_machine_info
    _set_block_size 4096
    _restart_alluxio

    # warm up.
    _sub_exp 8 1000 4096

    for i in {1..10}; do
        _sub_exp 16 1 $((4*1024*1024))
        _sub_exp 4 1000 $((4*1024))
    done

    _reset_block_size
}

main() {
    case $1 in
        0)
            reset
            ;;
        1)
            exp1
            ;;
        2)
            exp2
            ;;
        3)
            exp3
            ;;
        *)
            reset
            exp1
            exp2
            exp3
            ;;
    esac
}
   
main "$@"
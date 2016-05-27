#!/bin/bash
function copy {
  OP=$1
  TL=$2
  WT=$3

  cp ~/workspace/test/${OP}_${WT}_1.0.1_C32_${TL} c32_1.0.1.dat
  cp ~/workspace/test/${OP}_${WT}_1.1.0_C32_${TL} c32_1.1.0.dat
  cp ~/workspace/test/${OP}_${WT}_1.1.0_HDFS_C32_${TL} c32_hdfs.dat
  cp ~/workspace/test/${OP}_1.0.1_${WT}_RJ_C32_${TL} c32_rj_1.0.1.dat
  cp ~/workspace/test/${OP}_1.1.0_${WT}_RJ_C32_${TL} c32_rj_1.1.0.dat
  cp ~/workspace/test/${OP}_1.0.1_${WT}_C8_${TL} c8_1.0.1.dat
  cp ~/workspace/test/${OP}_1.1.0_${WT}_C8_${TL} c8_1.1.0.dat
  cp ~/workspace/test/${OP}_1.1.0_HDFS_C8_${TL} c8_hdfs.dat
}

cd ${1}/create_file_CACHE_THROUGH
copy CREATE_FILE ${1} CACHE_THROUGH
make
cd ../..

cd ${1}/create_file_MUST_CACHE
copy CREATE_FILE ${1}
make
cd ../..

cd ${1}/delete_file_CACHE_THROUGH
copy DELETE_FILE ${1} CACHE_THROUGH
make
cd ../..

cd ${1}/delete_file_MUST_CACHE
copy DELETE_FILE ${1}
make
cd ../..

cd ${1}/get_status_CACHE_THROUGH
copy LIST_STATUS ${1} CACHE_THROUGH
make
cd ../..

cd ${1}/get_status_MUST_CACHE
copy LIST_STATUS ${1}
make
cd ../..

cd ${1}/list_status_CACHE_THROUGH
copy LIST_STATUS_Dir ${1} CACHE_THROUGH
make
cd ../..

cd ${1}/list_status_MUST_CACHE
copy LIST_STATUS_Dir ${1}
make
cd ../..


#!/bin/bash

function copy {
  OP=$1
  TL=$2
  WT=$3

  cp ~/workspace/test/${OP}_${WT}_1.1.1_${TL} c32_baseline.dat
  cp ~/workspace/test/${OP}_${WT}_1.2.0_${TL} c32_new.dat

  cp ~/workspace/test/${OP}_${WT}_1.2.0_hdfs_${TL} c32_hdfs.dat

  cp ~/workspace/test/${OP}_${WT}_1.1.1_rj_${TL} c32_rj_baseline.dat
  cp ~/workspace/test/${OP}_${WT}_1.2.0_rj_${TL} c32_rj_new.dat
}

cd ${1}/create_file_CACHE_THROUGH
copy CREATE_FILE_0_false ${1} CACHE_THROUGH
make
cd ../..

cd ${1}/create_file_MUST_CACHE
copy CREATE_FILE_0_false ${1} MUST_CACHE
make
cd ../..

cd ${1}/delete_file_CACHE_THROUGH
copy DELETE_0_false ${1} CACHE_THROUGH
make
cd ../..

cd ${1}/delete_file_MUST_CACHE
copy DELETE_0_false ${1} MUST_CACHE
make
cd ../..

cd ${1}/get_status_CACHE_THROUGH
copy LIST_STATUS_0_false ${1} CACHE_THROUGH
make
cd ../..

cd ${1}/get_status_MUST_CACHE
copy LIST_STATUS_0_false ${1} MUST_CACHE
make
cd ../..

cd ${1}/list_status_CACHE_THROUGH
copy LIST_STATUS_1_false ${1} CACHE_THROUGH
make
cd ../..

cd ${1}/list_status_MUST_CACHE
copy LIST_STATUS_1_false ${1} MUST_CACHE
make
cd ../..

cd ${1}/get_status_missing_CACHE_THROUGH
copy LIST_STATUS_0_true ${1} CACHE_THROUGH
make
cd ../..

cd ${1}/get_status_missing_MUST_CACHE
copy LIST_STATUS_0_true ${1} MUST_CACHE
make
cd ../..


#!/bin/bash
function copy {
  OP=$1
  TL=$2
  CT=""
  if [[ -z $2 ]]; then
      CT="CT_"
  fi
  
  cp ~/workspace/test/${OP}_1.0.1_${CT}C32_${TL} c32_1.0.1.dat
  cp ~/workspace/test/${OP}_1.1.0_${CT}C32_${TL} c32_1.1.0.dat
  cp ~/workspace/test/${OP}_1.1.0_HDFS_C32_${TL} c32_hdfs.dat
  cp ~/workspace/test/${OP}_1.0.1_RJ_C32_${TL} c32_rj_1.0.1.dat
  cp ~/workspace/test/${OP}_1.1.0_RJ_C32_${TL} c32_rj_1.1.0.dat
  cp ~/workspace/test/${OP}_1.0.1_${CT}C8_${TL} c8_1.0.1.dat
  cp ~/workspace/test/${OP}_1.1.0_${CT}C8_${TL} c8_1.1.0.dat
  cp ~/workspace/test/${OP}_1.1.0_HDFS_C8_${TL} c8_hdfs.dat
}

cd ${1}/create_file_CACHE_THROUGH
copy CreateFile ${1} CT
make
cd ../..

cd ${1}/create_file_MUST_CACHE
copy CreateFile ${1}
make
cd ../..

cd ${1}/delete_file_CACHE_THROUGH
copy DeleteFile ${1} CT
make
cd ../..

cd ${1}/delete_file_MUST_CACHE
copy DeleteFile ${1}
make
cd ../..

cd ${1}/get_status_CACHE_THROUGH
copy ListStatus ${1} CT
make
cd ../..

cd ${1}/get_status_MUST_CACHE
copy ListStatus ${1}
make
cd ../..

cd ${1}/list_status_CACHE_THROUGH
copy ListStatus_Dir ${1} CT
make
cd ../..

cd ${1}/list_status_MUST_CACHE
copy ListStatus_Dir ${1}
make
cd ../..


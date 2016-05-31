#!/usr/bin/env bash

cat "${1}_MaxFile"  | grep '^CREATE_FILE_MF_MC.*_C80' -B2 | sed '/[a-z]/d' | grep '[1-9]' | sed 's/\(.*\) .*\\/\1/' > ${1}_MaxFile_runtime
cat "${1}_MaxFile" | awk 'BEGIN{count = 0} /./ {count = $1} END{print count}' >> ${1}_MaxFile_runtime

#/bin/bash

cat "${1}_MaxFile_C80"  | grep '^CREATE_FILE_MUST_CACHE.*_C80' -B2 | sed '/[a-z]/d' | grep '[1-9]' | sed 's/\(.*\) .*\\/\1/' > ${1}_MaxFile_runtime

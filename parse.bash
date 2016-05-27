#/bin/bash

split_file() {
    cat $1 | awk 'BEGIN{filename=""} /Thoughput unit:MB/ {filename=$1; system("> " filename); print filename} {print $0 >> filename} END{}' > /tmp/names
}

# 1: input
get_throughput() {
    cat $1 | sed '/[a-z][A-Z]*/d' | sed '/^[\space]*$/d' | sed 's/ *\(.*\)\\/\1/g'  | awk 'NF == 2 {print $0}' > "${1}_throughput"
}

# 1: input
get_latency() {
    cat $1 | sed '/[a-z][A-Z]*/d' | sed '/^[\space]*$/d' | sed 's/ *\(.*\)\\/\1/g'  | awk 'NF > 2 {print $0}' > "${1}_latency"
}

split_file $1
for i in $( cat /tmp/names ); do 
    get_latency $i
    get_throughput $i
    rm $i
done

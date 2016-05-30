#!/bin/bash

peak_throughput() {
    cat $1 | awk 'BEGIN{max = -1} $2 > max {max = $2} END{print max}'
}
> peak_thr_summary; for i in $( ls | grep 'throughput$' ); do echo -ne $i" " >> peak_thr_summary; peak_throughput $i >> peak_thr_summary;done;

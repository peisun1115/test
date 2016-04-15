#!/bin/bash

BIN=$1
./bp.bash ALLUXIO "Alluxio:" 20 10000 exp6 0 -t
cat /proc/meminfo > meminfo_6_after


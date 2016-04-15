#!/bin/bash

BIN=$1
ALLUXIO=$2

cat /proc/meminfo > meminfo_5_before

${BIN} ALLUXIO "Alluxio:" 4 100 exp5 0
cat /proc/meminfo > meminfo_5_0

${BIN} LOCAL "/mnt/ramdisk/alluxioworker" 100 10000 exp5 1
cat /proc/meminfo > meminfo_5_1

${BIN} ALLUXIO "Alluxio:" 4 100 exp5 2
cat /proc/meminfo > meminfo_5_2

${BIN} LOCAL "/mnt/ramdisk/alluxioworker" 100 10000 exp5 3
cat /proc/meminfo > meminfo_5_3

${BIN} ALLUXIO "Alluxio:" 4 100 exp5 4
cat /proc/meminfo > meminfo_5_4

${BIN} LOCAL "/mnt/ramdisk/alluxioworker" 100 10000 exp5 5
cat /proc/meminfo > meminfo_5_5

${BIN} ALLUXIO "Alluxio:" 4 100 exp5 6
cat /proc/meminfo > meminfo_5_6


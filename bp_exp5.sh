#!/bin/bash
./bp.sh ALLUXIO "Alluxio:" 2 10 "./exp5_0_0" 0
./bp.sh LOCAL "/mnt/ramdisk/alluxioworker" 25 1000 "./exp5_0_1" 1
./bp.sh ALLUXIO "Alluxio:" 2 10 "./exp5_0_2" 2
./bp.sh LOCAL "/mnt/ramdisk/alluxioworker" 250 1000 "./exp5_0_3" 3
./bp.sh ALLUXIO "Alluxio:" 2 10 "./exp5_0_4" 4
./bp.sh LOCAL "/mnt/ramdisk/alluxioworker" 250 10000 "./exp5_0_5" 5
./bp.sh ALLUXIO "Alluxio:" 2 10 "./exp5_0_6" 6


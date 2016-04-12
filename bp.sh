#!/bin/bash                                                                                        

for ((i = 0; i < $1; i++)); do
   for ((j = 0; j < $2; j++)); do
     time ( echo "i:$i,j:$j" > /mnt/ramdisk/alluxioworker/f_${i}_${j} ) >> /tmp/stats
done



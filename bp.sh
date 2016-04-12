#!/bin/bash

>/tmp/stats
for ((i = 0; i < $1; i++)); do
    real=0
    sys=0
    usr=0
    for ((j = 0; j < $2; j++)); do
	time -p ( echo "i:$i,j:$j" > /mnt/ramdisk/alluxioworker/f_${i}_${j} ) &>/tmp/s
	real=$(echo "${real} + $(cat /tmp/s | grep 'real' | cut -d ' ' -f2)" | bc)
	sys=$(echo "${sys} + $(cat /tmp/s | grep 'sys' | cut -d ' ' -f2)" | bc)
	usr=$(echo "${usr} + $(cat /tmp/s | grep 'usr' | cut -d ' ' -f2)" | bc)
   done
   echo ${real}" "${sys}" "${usr} >> /tmp/stats
done



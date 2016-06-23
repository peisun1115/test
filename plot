#plot commands
set terminal png size 1280,720
set output 'result.png'

set title "SparkStreaming"
set key top right
set linestyle 1 lt 2 lw 3 linecolor rgb "navy"
set linestyle 3 lt 2 lw 3 linecolor rgb "orange"
set bmargin 4
set rmargin 5
set ylabel "Words/Second"
set xlabel "Seconds"
plot 'output_alluxio_parsed' using 1:2 title "Alluxio" with lines ls 1, \
     'output_s3_parsed' using 1:2 title "S3" with lines ls 2

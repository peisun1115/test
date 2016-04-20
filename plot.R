pdf('./block_performance_result.pdf')

runtime_secs <- read.table("/tmp/exp2_result")
num_files <- seq(10000, 200000, 10000)
matplot(num_files, runtime_secs, col=c(3,4,6), pch=c(1,3,4))
lends <- c("1.0.1_after_fix", "master_no_fix", "1.0.1_no_fix")
legend('topleft', lends, col = c(3, 4, 6), text.col = "green4",
    pch = c(1, 3, 4), bg = "gray90")
title('10K files (size=4KB) per batch. 20 batches. block size: 0.5GB')


runtime_secs <- read.table("/tmp/exp3_result")
num_files <- seq(10, 220, 10)
matplot(num_files, runtime_secs, col=c(3,6), pch=c(1,4))
lends <- c("1.0.1_no_fix", "1.0.1_after_fix")
legend('topleft', lends, col = c(3, 6), text.col = "green4",
    pch = c(1, 4), bg = "gray90")
title('10 files (4MB) per batch. 22 batches. block size: 4KB')

dev.off()

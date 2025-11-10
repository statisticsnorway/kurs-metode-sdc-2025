# Run the following code to make sure that sdcMicro is installed and works as intended.
# This requires a working installation of R (2.10 or higher) and sdcMicro.

# Uncomment this to install sdcMicro from CRAN:
# install.packages("sdcMicro")

library(sdcMicro) 
data(francdat)
f <- freqCalc(francdat, keyVars=c(2, 4:6), w = 8)
f$fk

# Output should be:
# [1] 2 2 2 1 1 1 1 2

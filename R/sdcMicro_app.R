# Useful commands:
# install.packages("sdcMicro", dependencies = TRUE) # install sdcMicro package
# library(sdcMicro) # Loads the sdcMicro package
# ?sdcMicro # Views the sdcMicro help page
# ls("package:sdcMicro") # Lists functions and data provided by sdcMicro
# load(data/persons) # Loads the persons dataset from the data folder
# ?createSdcObj # Shows documentation for the createSdcObj function
# ?globalRecode # Shows documentation for the global recode function
# ?localSuppression # Shows documentation for the localSuppression function
# slotNames(sdc_0) # Print slots of the sdcMicroObj named sdc_0
# sdcApp() # Launch sdcApp (opens in browser window)

# Useful resources:
# https://sdctools.github.io/sdcMicro/index.html # sdcMicro online documentation


# Load sdcMicro package
library(sdcMicro)

# Launch sdcApp (opens in browser window)
sdcApp() # The object x will contain the microdata and the sdc problem
# The app will open in a web-browser. 

## Anonymization can be done in the sdcApp, and it can be used to generate R-code.
## 

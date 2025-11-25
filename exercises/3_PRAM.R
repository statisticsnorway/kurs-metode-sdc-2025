###############################################################################
# Exercise 3: Apply PRAM. Answer the questions.
###############################################################################

library(sdcMicro)

# Set seed for reproducibility
set.seed(1)

# Load and view the persons sample dataset
load(file = "data/persons.Rdata")
names(persons)
print(persons)

# Change Birth_year = 9999 to NA
persons[which(persons$Birth_year==9999), "Birth_year"] <- NA

# Turn gender into a factor variable
# This is required when using PRAM
persons$Gender <- as.factor(persons$Gender)

# Make valid transition matrix
levels(persons$Gender)
p <- matrix(c(0.7, 0.3, 0.3, 0.7), nrow = 2, ncol = 2)
rownames(p) <- colnames(p) <- levels(persons$Gender)
print(p)

# Create an sdcMicroObj based on the persons sample dataset.
# Direct identifier: Person_id
# Key variables: Gender, Birth_year, Region
# Sensitive variable: Income
# Weight variable: Weight
sdc_0 <- createSdcObj(
  dat = persons,  
  excludeVars = c("Person_id"), 
  keyVars = c("Gender", "Birth_year", "Region"), 
  sensibleVar = c("Income"), 
  weightVar = c("Weight"),
)

# Apply PRAM on the Gender variable with transition matrix p
sdc_pram <- pram(sdc_0, var = "Gender", pd = p)

# Q1: Run 'sdc_pram@pram'. How many values was changed to another value?

# Q2: Rerun the whole script with a diagonal matrix:
# 'p <- matrix(c(1.0, 0.0, 0.0, 1.0), nrow = 2, ncol = 2)'
# Which changes happens to the data?

# Extract and inspect the modified dataset
df_out_pram <- extractManipData(sdc_pram)
print(df_out_pram)

# Generate report
report(sdc_pram, outdir = "reports", filename = "report_pram.html")





###############################################################################
# Useful commands and resources
###############################################################################
# library(sdcMicro) # Loads the sdcMicro package
# ?sdcMicro # Views the sdcMicro help page
# ls("package:sdcMicro") # Lists functions and data from sdcMicro
# load(file = "data/persons.Rdata") # Loads the persons dataset
# ?createSdcObj # Shows documentation for the createSdcObj function
# slotNames(sdc_0) # Print slotnames of the object sdc_0
# ?measure_risk # Description of the different risk measures
# ?groupAndRename # Shows documentation for the groupAndRename function
# ?localSuppression # Shows documentation for the localSuppression function
# ?pram # Shows documentation for the pram function
# df_out <- extractManipData(sdc_4) # Extracts the manipulated dataset stored in sdc_4
# report(sdc_4, outdir = "rep", filename = "my_rep.html") # Generates a report for sdc_4
# https://sdctools.github.io/sdcMicro/index.html # sdcMicro online documentation
# https://sdcpractice.readthedocs.io/en/latest/sdcMicro.html#id11 # Slot descriptions
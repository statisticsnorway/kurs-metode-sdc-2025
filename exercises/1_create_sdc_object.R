###############################################################################
# Exercise 1: Run the commands below and answer Q1 to Q7.
###############################################################################

library(sdcMicro)

# Load and view the persons sample dataset
load(file = "data/persons.Rdata")
names(persons)
print(persons)

# Change Birth_year = 9999 to NA
persons[which(persons$Birth_year==9999), "Birth_year"] <- NA

# Create an sdcMicroObj based on the persons sample dataset.
# Direct identifier: Person_id
# Key variables: Gender, Birth_year, Area
# Sensitive variable: Income
# Weight variable: Weight
sdc_0 <- createSdcObj(
  dat = persons,  
  excludeVars = c("Person_id"), 
  keyVars = c("Gender", "Birth_year", "Region"), 
  sensibleVar = c("Income"), 
  weightVar = c("Weight"),
)

# Q1: Run 'sdc_0@origData' and compare it to 'print(persons)'. Which variable 
# is missing, and why is it missing?

# Q2: Run 'sdc_0@deletedVars' to see which variables has been deleted. Confirm 
# that the result aligns with Q1.

# Q3: Run 'slotNames(sdc_0)'. Which slot returns the key variables of obj_0?

# Q4: Run 'sdc_0@risk'. What is the global risk (expected fraction of 
# reidentifications)?

# Q5: Run 'sdc_0@risk$individual' to see the individual risks. What is the 
# highest individual risk?

# Q6: Which key (combination of key variables) appears three times in the dataset?

# Q7: How many records violate 2-anonymity (i.e., they are sample unique)?

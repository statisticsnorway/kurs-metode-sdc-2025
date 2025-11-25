###############################################################################
# Exercise 2: Apply recoding and local suppression. Answer the questions.
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

# Apply global recoding to variable Region
# Replace A1, A2, A3 with A
# Replace B1, B2, B3 with B
# Replace C1, C2 with C
sdc_1 <- groupAndRename(sdc_0, var="Region", before=c("A1","A2","A3"), after=c("A"))
sdc_2 <- groupAndRename(sdc_1, var="Region", before=c("B1","B2","B3"), after=c("B"))
sdc_3 <- groupAndRename(sdc_2, var="Region", before=c("C1","C2"), after=c("C"))

# Q1: Compare 'sdc_0@manipKeyVars' with 'sdc_3@manipKeyVars'. How many records 
# have Region == "A" after recoding?

# Q2: Run 'print(sdc_0)'. How many records violates 2-anonymity before recoding?

# Q3: Run 'print(sdc_3)'. How many records violates 2-anonymity after recoding?

# Q4: What is the global risk before and after recoding?



# Apply local suppression to achieve 2-anonymity
sdc_4 <- localSuppression(sdc_3, k = 2)

# Q5: Run 'sdc_4@localSuppression'. How many values has been suppressed?

# Q6: Run 'print(sdc_4)'. How many records violates 2-anonymity after suppression?

# Q7: What is the global risk after local suppression?

# Q8: What is the highest individual risk after local suppression?



# Generate report
report(sdc_4, outdir = "reports", filename = "report_ls.html", internal = TRUE, verbose = TRUE)

# Q9: Find and open the report. Find the list with the ten combinations with the
# highest risk. What is the most risky combination, and what is the individual 
# risk of this combination?



# Extract the modified dataset
df_out <- extractManipData(sdc_4)

# Q10: Run 'print(df_out)' to see the modified dataset. Check that the data is 
# correctly recoded and suppressed.





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
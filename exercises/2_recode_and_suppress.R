###############################################################################
# Exercise 2: Apply recoding and local suppression.
###############################################################################

library(sdcMicro)

# Load and view the persons sample dataset
load(file = "data/persons.Rdata")
names(persons)
print(persons)

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

# Apply global recoding to variable Region
# Replace A1, A2, A3 with A
# Replace B1, B2, B3 with B
# Replace C1, C2 with C
sdc_1 <- groupAndRename(sdc_0, var="Region", before=c("A1","A2", "A3"), after=c("A"))
sdc_2 <- groupAndRename(sdc_1, var="Region", before=c("B1","B2", "B3"), after=c("B"))
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






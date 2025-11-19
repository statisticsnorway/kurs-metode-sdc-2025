#Sys.setlocale("LC_ALL", "no_NB.utf8")
library(GaussSuppression)
library(dplyr)
library(tidyr)
library(knitr)

#Vignette: https://cran.r-project.org/web/packages/GaussSuppression/vignettes/Magnitude_table_suppression.html

###############################
##
## Import and recode the data:
##
###############################
# Import data:
dataset <- SSBtoolsData("magnitude1")
# Select a subset of the data:
dataset <- subset(dataset, sector4 == "Entertainment" | sector4 =="Agriculture" | sector4 == "Industry", select = - c(sector2, eu, company))
# rename 
names(dataset)[1] <- "sector"
# View the data:
dataset


##############################
#
# Example I:
# SDMX for suppression 
# of few contributors:
#
##############################
## Suppress cells based on the number of contributors:
outFew <- SuppressFewContributors(data=dataset, 
                                  numVar = "value", 
                                  dimVar = c("sector", "geo"), 
                                  maxN=2)
outFew


# Create SDMX-status:
outFew$SDMX_status <- ifelse(outFew$suppressed == TRUE, "D", "F") # SDMX code for secondary or free cells.
outFew$SDMX_status[outFew$primary == TRUE] <- "C"  # SDMX code for primary suppressed cells.
# Create SDMX-reason:
outFew$SDMX_reason <- outFew$SDMX_status
outFew$SDMX_reason[outFew$primary] <- "A" # SDMX code for suppression due to few contributors.
outFew

#############################################
#
# Example II:
# SDMX for suppression based on 
# dominance rule:
#
#############################################
## Suppress cells based on the dominance rule with thresholds (1, 60%) and (2, 90%):
outDom <- SuppressDominantCells(
  data = dataset,
  numVar = "value",
  dimVar = c("sector", "geo"),
  n = 1:2, # Dominance rule
  k = c(65, 90), # Dominance rule
  allDominance = TRUE
)
outDom

## Create codes for SDMX-status:
outDom$SDMX_status <- ifelse(outDom$suppressed == TRUE, "D", "F") # SDMX code for secondary or free cells.
outDom$SDMX_status[outDom$primary == TRUE] <- "C" # SDMX code for primary suppressed cells.
outDom
## Create codes for SDMX-reason:
outDom$SDMX_reason <- outDom$SDMX_status
outDom$SDMX_reason[outDom$dominant2 >= 0.90] <- "T" # SDMX code for dominance due to two units.
outDom$SDMX_reason[outDom$dominant1 >= 0.65] <- "O" # SDMX code for dominance due to one unit.
# View output:
outDom


#############################################
#
# Example III:
# SDMX for suppression based on 
# dominance rule and few contributors:
#
#############################################
## It is also possible to suppress cells based on both the dominance rule 
## with thresholds (1, 60%) and (2, 90%) and the maximum number of contributions (maxN):
outDomN <- SuppressDominantCells(
  data = dataset,
  numVar = "value",
  dimVar = c("sector", "geo"),
  n = 1:2, # Dominance rule
  k = c(65, 90), # Dominance rule
  maxN = 3, # maximum number of contributions
  allDominance = TRUE
)
outDomN

## Create codes for SDMX-status:
outDomN$SDMX_status <- ifelse(outDomN$suppressed == TRUE, "D", "F") # SDMX code for secondary or free cells.
outDomN$SDMX_status[outDomN$primary == TRUE] <- "C" # SDMX code for primary suppressed cells.
outDomN
## Create codes for SDMX-reason:
outDomN$SDMX_reason <- outDomN$SDMX_status
outDomN$SDMX_reason[outDomN$dominant2 >= 0.90] <- "T" # SDMX code for dominance due to two units.
outDomN$SDMX_reason[outDomN$dominant1 >= 0.65] <- "O" # SDMX code for dominance due to one unit.
outDomN$SDMX_reason[outDomN$n_contr != 0 & outDomN$n_contr <= 2] <- "A" # SDMX code for suppression due to few contributors.
outDomN
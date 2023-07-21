
################################################################
# Sum up MOTU counts from the same taxa.
# 
# Script created by MORAIS, D.K. and BRANDNER, M.M.
# Contact at daniel.morais@uit.no
#
# Created (20/07/2023)
# Version v 0.1 
#
# R version 4.2.3
# tidyverse_2.0.0, dplyr_1.1.2, purrr_1.0.1, tidyr_1.3.0
#
#######################################################################

# Load your library
library(tidyverse)

# Set your work environment
setwd(dir = "G:/My Drive/UiT_projects/Research/MelissaB/Scripts_to_automatize/")

# Read your MOTU table
MOTU_tab_no_blanks <- read_delim(file = "MOTU_tab_without_blanks.txt")

total_reads_col <- which(names(MOTU_tab_no_blanks) == "total_reads")
TaxID_col <- which(names(MOTU_tab_no_blanks) == "taxid")
Sequence_col <- which(names(MOTU_tab_no_blanks) == "sequence")

samples_columns <- c(total_reads_col,(TaxID_col+1):(Sequence_col-1))

MOTU_tab_no_blanks %>% group_by(scientific_name) %>% summarise(across(samples_columns,sum))



(TaxID_col+1):(Sequence_col-1)



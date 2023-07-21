
################################################################
# Sum of MOTU counts from the same taxa.
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

# To choose the columns that represent our samples and the total reads per MOTU, we are assuming a few things:
# 1) We will always have a "total_reads" column
# 2) We will always have our samples between the columns named "taxid" and "sequence"
# If any of these assumptions are broken, the script won't work.

# Identifying col indices
total_reads_col <- which(names(MOTU_tab_no_blanks) == "total_reads")
TaxID_col <- which(names(MOTU_tab_no_blanks) == "taxid")
Sequence_col <- which(names(MOTU_tab_no_blanks) == "sequence")
samples_columns <- c(total_reads_col,(TaxID_col+1):(Sequence_col-1))

# Finding their names
samples_columns_names <- MOTU_tab_no_blanks %>%
  select(samples_columns) %>% 
  names()

# Collapsing by scientific_name
collapsed_by_scientific_name <- MOTU_tab_no_blanks %>% 
  group_by(scientific_name) %>% 
  summarise(across(samples_columns_names,sum))

# Collapsing by species name
MOTU_tab_no_blanks %>% 
  group_by(species_name) %>% 
  summarise(across(samples_columns_names,sum))

# Collapsing by species list
MOTU_tab_no_blanks %>% 
  group_by(species_list) %>% 
  summarise(across(samples_columns_names,sum))

# Collapsing by taxa ID
MOTU_tab_no_blanks %>% 
  group_by(taxid) %>% 
  summarise(across(samples_columns_names,sum))

# writing the MOTU_tab_without_the_blanks
write.table(x = collapsed_by_scientific_name, file = "MOTU_tab_without_blanks_collapsed_by_scientific_name.txt", quote = F, sep = "\t", row.names = F)

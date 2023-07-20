################################################################
# Remove MOTUs that have more than 10% of their reads in a 
# random blank sample.
# 
# Script created by MORAIS, D.K. and Brandner, M.M.
# Contact at daniel.morais@uit.no
#
# Created (20/07/2023)
# Version v 0.1 
#
# To identify the blank samples, the script is searching for column 
# names that start with either the words "BLANK" or "PCRBL" 
# (it can be capitals or small letters or even a mixture), 
# be sure to avoid starting sample names with those words otherwise 
# they can be identified as blanks.
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
MOTU_tab <- read_delim(file = "MOTU_finaldataset_test_R_AeN.txt")

# Identify your blank samples
blank_cols <- MOTU_tab %>%
  names() %>%
  stringr::str_detect(pattern = "^[Bb][Ll][Aa][Nn][Kk]*|^[Pp][Cc][Rr][Bb][Ll]*") %>%
  which()

# See if they were chosen correctly
names(MOTU_tab)[blank_cols]

# Pick randomly one of the blank samples, setting a "seed" for consistency
set.seed(seed = 309)
colmn_to_be_used_as_blank_reference <- sample(x = blank_cols, 1)
colmn_name_to_be_used_as_blank_reference <- names(MOTU_tab)[colmn_to_be_used_as_blank_reference]

# Quantify the percentage of blank reads in each MOTU
rows_where_blank_is_bigger_than_10percent <- which(MOTU_tab[,colmn_to_be_used_as_blank_reference] / MOTU_tab$total_reads > 0.1)

######
# Internal checking to see if it worked.
#
# MOTU_tab[rows_where_blank_is_bigger_than_10percent,c("total_reads", colmn_name_to_be_used_as_blank_reference)]
# data.frame(MOTU_tab[rows_where_blank_is_bigger_than_10percent,c("total_reads", colmn_name_to_be_used_as_blank_reference)], math=(MOTU_tab[,colmn_to_be_used_as_blank_reference] / MOTU_tab$total_reads)[rows_where_blank_is_bigger_than_10percent,])
######

# Create an object without the MOTUs with too many blank reads (> 10%) and removing the blank columns
MOTU_tab_without_blank <- MOTU_tab %>% slice(-rows_where_blank_is_bigger_than_10percent) %>% select(-blank_cols)

# writing the MOTU_tab_without_the_blanks
write.table(x = MOTU_tab_without_blank, file = "MOTU_tab_without_blanks.txt", quote = F, sep = "\t", row.names = F)




#+++++++++++++++++++++++++++++++++++#
#   THE COMPLETE POKéMON DATASET    #
#+++++++++++++++++++++++++++++++++++#

#+++++++++++++++++++++++++++++++++++#
#                                   #
# 02    Pokémon summary data        #
#                                   #
#+++++++++++++++++++++++++++++++++++#

#+++++++++++++++++++++++++++++++++++#
# RUN 01_pokemon_data_preparation.R #
#   BEFORE RUN THE CURRENT SCRIPT   #
#+++++++++++++++++++++++++++++++++++#

#-----------------------------------#
# AA   Set working environment      # 
#-----------------------------------#

# install required libraries
# install.packages("xlsx")
# install.packages("tidyr")

# load libraries
library(xlsx)
library(tidyr)

# set path for input/output 
path_output_data = "F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_Pokémon/R_Pokemon/Pokémon_output/Pokémon_output_data/"
path_processed_data = "F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_Pokémon/R_Pokemon/Pokémon_data/Pokémon_data_processed/"

# set functions folder
functions_folder = "F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_Pokémon/R_Pokemon/Pokémon_functions"

#-----------------------------------#
# 02.0.1    General df features     # 
#-----------------------------------#

# check df appearence
head(pokemon)

# check data size
dim(pokemon)

# check structure
str(pokemon)

#-----------------------------------#
# 02.1.0    Discrete variables      #
#-----------------------------------#

#-----------------------------------#
# 02.1.1  Univariate statistics     #
#-----------------------------------#

# discrete variables absolute frequencies
discr_var_abs_freq = lapply(pokemon[4:14], table)

# discrete variables relative percentage frequencies
discr_var_rel_freq = sapply(apply(pokemon[4:14], 2, table), function(x) round((x/sum(x))*100,2))

# abilities - total abs frequencies
table(unlist(pokemon[,9:14]))

# abilities - total relative percentage frequencies
round(prop.table(table(unlist(pokemon[,9:14])))*100,2)

# abilities - total number of abilites 
colSums(!is.na(pokemon[,9:14]))

# abilities - total number of abilites as percentage
round(colSums(!is.na(pokemon[,9:14]))/ sum(colSums(!is.na(pokemon[,9:14])))*100,2)

# number of abilities by pokemon
rowSums(!is.na(pokemon[,9:14]))









#-----------------------------------#
# 02.2.0  Continuous variables      #
#-----------------------------------#

#-----------------------------------#
# 02.2.1  Univariate statistics     #
#-----------------------------------#

# sourcing 
source(paste(functions_folder, "pokemon_functions.R", sep = '/'))

# summary statistics of continuous variables
cont_var_summary = round(t(apply(subset(pokemon[,c(15:45)]), 2, enhanced_summary)),2)

# export
write.xlsx (cont_var_summary, file=paste0(path_output_data, "pokemon_df_", format(Sys.time(), "%Y%m%d"), ".xlsx"), sheetName="Continuos variables summary", row.names=T, append = T)
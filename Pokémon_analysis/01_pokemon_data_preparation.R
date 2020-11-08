#+++++++++++++++++++++++++++++++++++#
#   THE COMPLETE POKéMON DATASET    #
#+++++++++++++++++++++++++++++++++++#

#+++++++++++++++++++++++++++++++++++#
#                                   #
# 01  Pokémon data preparation      #
#                                   #
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
# 01.1.0      Read data             # 
#-----------------------------------#

# import dataset pokemon.csv
pokemon = read.csv(file.choose(), dec = ".", encoding="UTF-8", stringsAsFactors=FALSE)

rownames(pokemon) <- pokemon[["name"]]


# check df appearence
head(pokemon)

# check data size
dim(pokemon)

# check structure
str(pokemon)

#-----------------------------------#
# 01.1.1    Data editing            # 
#-----------------------------------#

# encoding pokemon classification column to display accent
Encoding(pokemon$classfication) <- "latin1"

# make capital the the first header letter 
headers = gsub("(?<=^|_)([a-z])", "\\U\\1", colnames(pokemon), perl=TRUE)

# replace headers with new ones
colnames(pokemon) = headers

# edit some variables names to look smarter
colnames(pokemon)[28] <- "Height_m"
colnames(pokemon)[37] <- "Type_1"
colnames(pokemon)[38] <- "Type_2"

# make type_1 and type_2 levels look better
pokemon$Type_1 = as.factor(gsub("(?<=^|_)([a-z])", "\\U\\1", pokemon$Type_1, perl=TRUE))
pokemon$Type_2 = as.factor(gsub("(?<=^|_)([a-z])", "\\U\\1", pokemon$Type_2, perl=TRUE))

# loof fot NA in Type_2
levels(pokemon$Type_2)

# type 2: it can also be null

# assign level to null
levels(pokemon$Type_2)[1] <- "None"

# edit generation name to display roman numeral
Generation = factor(pokemon$Generation, levels=c(1:7), labels = as.roman(c(1:7)))

# replace column
pokemon$Generation <- Generation

# edit ability column to obtain one column for each 

# remove square brackets from abilities variable
pokemon$Abilities =   gsub("\\[","",as.character(pokemon$Abilities))
pokemon$Abilities =   gsub("\\]","",as.character(pokemon$Abilities))

# removing also single quotes
pokemon$Abilities =   gsub("\\'","",as.character(pokemon$Abilities))

# check the maximum number of abilities before splitting columns
max(sapply(strsplit(as.character(pokemon$Abilities),','),length))

# set variables names for abilities
abilities_names_split = c("Ability_1", "Ability_2", "Ability_3", "Ability_4", "Ability_5", "Ability_6" )

# split ability column
pokemon = separate(pokemon, Abilities, abilities_names_split, sep=",")

# add region using assign_region function

# source function from file
source(paste(functions_folder, "pokemon_functions.R", sep = '/'))

# running function
pokemon$Region = as.factor(assign_region(pokemon))

#-----------------------------------#
# 01.1.2       Missing data         # 
#-----------------------------------#

# look for missing data 
pokemon_na <- apply(pokemon, MAR = 2, FUN = function(x) which(is.na(x))) 
pokemon_na[sapply(pokemon, length) > 0]

# check missing
pokemon_na$Height_m
pokemon_na$Weight_Kg
pokemon_na$Percentage_Male

subset(pokemon, is.na(Height_m) | is.na(Weight_Kg))[, c("Name", "Height_m", "Weight_Kg")]

# build list with height and weight from pokédex
missing_height_weight <- list(Rattata   = c(Height_m = 0.3, Weight_Kg =   3.5), 
                              Raticate  = c(Height_m = 0.7, Weight_Kg =  18.5),
                              Raichu    = c(Height_m = 0.8, Weight_Kg =  30.0),
                              Sandshrew = c(Height_m = 0.6, Weight_Kg =  12.0),
                              Sandslash = c(Height_m = 1.0, Weight_Kg =  29.5),
                              Vulpix    = c(Height_m = 0.6, Weight_Kg =   9.9),
                              Ninetales = c(Height_m = 1.1, Weight_Kg =  19.9),
                              Diglett   = c(Height_m = 0.2, Weight_Kg =   0.8),
                              Dugtrio   = c(Height_m = 0.7, Weight_Kg =  33.3),
                              Meowth    = c(Height_m = 0.4, Weight_Kg =   4.2),
                              Persian   = c(Height_m = 1.0, Weight_Kg =  32.0),
                              Geodude   = c(Height_m = 0.4, Weight_Kg =  20.0),
                              Graveler  = c(Height_m = 0.3, Weight_Kg = 105.0),
                              Golem     = c(Height_m = 1.4, Weight_Kg = 300.0),
                              Grimer    = c(Height_m = 0.9, Weight_Kg =  30.0),
                              Muk       = c(Height_m = 1.2, Weight_Kg =  30.0),
                              Exeggutor = c(Height_m = 2.0, Weight_Kg = 120.0),
                              Marowak   = c(Height_m = 1.0, Weight_Kg =  45.0),
                              Hoopa     = c(Height_m = 0.5, Weight_Kg =   9.0),
                              Lycanroc  = c(Height_m = 0.8, Weight_Kg =  25.0))

missing_height_weight <- t(rbind.data.frame(missing_height_weight))

# replace data
pokemon[match(rownames(missing_height_weight), pokemon[["Name"]]), c("Height_m", "Weight_Kg")] <- missing_height_weight

# look at male percentage
head(subset(pokemon, is.na(Percentage_Male)))

# check NAs which pokémon belong to
subset(pokemon, is.na(Percentage_Male) | is.na(Percentage_Male))[, c("Name", "Percentage_Male")]

# since NAs belong to genderless pokèmon replace the value with 0.5 could represent a equal spit
pokemon[is.na(pokemon[["Percentage_Male"]]), "Percentage_Male"] <- 0.5

# cast Is_legendary to factor
pokemon[["Is_Legendary "]] <- factor(as.character(pokemon[["Is_Legendary "]]))

# cast Capture_Rate as factor to inspect levels
pokemon[["Capture_Rate"]] <- as.factor(pokemon$Capture_Rate)

# check
levels(pokemon$Capture_Rate)

# look at what pokemon belong to
rownames(pokemon)[which(pokemon$Capture_Rate == "30 (Meteorite)255 (Core)", arr.ind=TRUE)]

# replace value
pokemon$Capture_Rate <- as.character(pokemon$Capture_Rate)
pokemon$Capture_Rate[774] <- "30"
pokemon$Capture_Rate  = as.numeric(pokemon$Capture_Rate)

# removing name column 
pokemon = pokemon[,-36]

# reorder columns
pokemon = pokemon[,c(35,37,30,44,46,45,41,42,1:6,7:24,34,33,43,25,31,38,39,40,26,32,27,28,29)]

pokemon_out = pokemon[,-1]

# export the dataset as csv for further analysis
write.csv (pokemon_out, file=paste0(path_processed_data, "pokemon_out_df_", format(Sys.time(), "%Y%m%d"), ".csv"), row.names=T)

# export the df as .xlsx as  final output
write.xlsx (pokemon, file=paste0(path_output_data, "pokemon_df_", format(Sys.time(), "%Y%m%d"), ".xlsx"), sheetName="pokemon_df", row.names=T, append = T)
#+++++++++++++++++++++++++++++++++++#
#   THE COMPLETE POKéMON DATASET    #
#+++++++++++++++++++++++++++++++++++#

#+++++++++++++++++++++++++++++++++++#
#                                   #
# 02    Pokémon summary data        #
#        Data visualization         #
#                                   #
#+++++++++++++++++++++++++++++++++++#

#+++++++++++++++++++++++++++++++++++#
# RUN 02_......summary_statistics.R #
#   BEFORE RUN THE CURRENT SCRIPT   #
#+++++++++++++++++++++++++++++++++++#

#-----------------------------------#
# AA   Set working environment      # 
#-----------------------------------#

# install required libraries
# install.packages("xlsx")
# install.packages("tidyr")
# install.packages("ggplot2")

# load libraries
library(xlsx)
library(tidyr)
library(ggplot2)

# set path for input/output 
path_output_data = "F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_Pokémon/R_Pokemon/Pokémon_output/Pokémon_output_data/"
path_output_fig = "F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_Pokémon/R_Pokemon/Pokémon_output/Pokémon_output_fig/"
path_processed_data = "F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_Pokémon/R_Pokemon/Pokémon_data/Pokémon_data_processed/"

#-----------------------------------#
# 02.0.1      Read data             # 
#-----------------------------------#

# import dataset (optional)
# pokemon = read.csv(file.choose(), dec = ".")

# check df
head(pokemon)

#-----------------------------------#
# 02.1.0    DISCRETE VARIABLES      #
#-----------------------------------#

# overall abilities number

# creating first a df to pass to ggplot function
ability_total_df = data.frame(names(colSums(!is.na(pokemon[,9:14]))), colSums(!is.na(pokemon[,9:14])), row.names = NULL)
colnames(ability_total_df) = c("Ability", "Abundance")

# barplot
ggplot(data=ability_total_df, aes(x= reorder(Ability, -Abundance), y=Abundance, fill=Ability)) +     
  geom_bar(stat="identity") +
  geom_text(aes(label=Abundance), vjust=-0.5, color="Black", size=3.5) +
  theme(legend.position = "none") +
  xlab(label = "Number of abilities") +
  ylab(label = "Number of Pokémon") +
  ggtitle(label = "Number of abilities by Pokemon") +
  theme(plot.title = element_text(hjust = 0.5)) 


# pokemon abundance accoding to their type_1 

# creating first a df to pass to ggplot function
type_1_total_df = as.data.frame(discr_var_abs_freq$Type_1)
colnames(type_1_total_df) = c("Type_1", "Abundance")

# creating color vector with proper color
pokemon_type_1_color = c("yellowgreen", "gray25", "lightslateblue", "orange", "orchid1", "chocolate4", "red1", "steelblue2", "royalblue3",
                         "chartreuse2", "lightgoldenrod3", "cadetblue1", "cornsilk3", "magenta4","maroon2", "khaki4", "grey69", "dodgerblue" )

# barplot
ggplot(data=type_1_total_df, aes(x= reorder(Type_1, -Abundance), y=Abundance, fill=Type_1)) +     
  geom_bar(stat="identity") +
  geom_text(aes(label=Abundance), vjust=-0.5, color="Black", size=3.5) +
  theme(legend.position = "none") +
  xlab(label = "Type 1") +
  ylab(label = "Number of Pokémon") +
  ggtitle(label = "Number of Pokemon for each type") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.85, hjust=1)) +
  scale_fill_manual(values = pokemon_type_1_color)

# since Pokémon number within region isn't equal lets consider relative percentage

# calculating percentage within type 1
type_1_df$Relative_abundance = round(((type_1_df$Abundance/rep(region_df$Abundance, each = length(levels(type_1_df$Type_1))))*100),2)

# plot
ggplot(type_1_df, aes(y = Relative_abundance, x = Type_1 , fill = Type_1 )) + 
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5), plot.title = element_text(hjust = 0.5))+
  guides(fill=guide_legend(title="Type 1")) + 
  geom_bar(stat = 'identity') + facet_grid(Region ~.) + 
  labs(title = "Type Of Pokemon Over Regions",x="Type",y="Type composition as percentage") +
  scale_fill_manual(values = pokemon_type_1_color)

# Pokémon abundance according to their type_2

# creating first a df to pass to ggplot function
type_2_total_df = as.data.frame(discr_var_abs_freq$Type_2)
colnames(type_2_total_df) = c("Type_2", "Abundance")

# creating color vector with proper color
pokemon_type_2_color = c("yellowgreen", "gray25", "lightslateblue", "orange", "orchid1", "chocolate4", "red1", "steelblue2", "royalblue3",
                         "chartreuse2", "lightgoldenrod3", "cadetblue1", "slategray","cornsilk3", "magenta4","maroon2", "khaki4", "grey69", "dodgerblue" )

# barplot
ggplot(data=type_2_total_df, aes(x= reorder(Type_2, -Abundance), y=Abundance, fill=Type_2)) +     
  geom_bar(stat="identity") +
  geom_text(aes(label=Abundance), vjust=-0.5, color="Black", size=3.5) +
  theme(legend.position = "none") +
  xlab(label = "Type 2") +
  ylab(label = "Number of Pokémon") +
  ggtitle(label = "Number of Pokemon for each type") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.85, hjust=1)) +
  scale_fill_manual(values = pokemon_type_2_color)

# pokèmon abundance according to region

# creating first a df to pass to ggplot function
region_total_df = as.data.frame(table(pokemon$Region, dnn = "Region"), responseName = "Abundance")

# plot
ggplot(data=region_df, aes(x= reorder(Region, Abundance), y=Abundance, fill=Region)) +     
  geom_bar(stat="identity") +
  geom_text(aes(label=Abundance), vjust=1.6, color="Black", size=3.5) +
  xlab(label = "Regions") +
  ylab(label = "Number of Pokémon") +
  ggtitle(label = "Pokémon abundance by Region") +
  theme(plot.title = element_text(hjust = 0.5))

# legendary pokèmon abundance according to region
legendary_df = as.data.frame(table(subset(pokemon$Is_Legendary, pokemon$Is_Legendary == 1), subset(pokemon$Region, pokemon$Is_Legendary == 1)))
legendary_df = legendary_df[,-1]

colnames(legendary_df) <- c("Region", "Abundance")

# plot
ggplot(data=legendary_df, aes(x= reorder(Region, Abundance), y=Abundance, fill=Region)) +     
  geom_bar(stat="identity") +
  geom_text(aes(label=Abundance), vjust=1.6, color="Black", size=3.5) +
  xlab(label = "Regions") +
  ylab(label = "Number of Pokémon") +
  ggtitle(label = "Legendary Pokèmon abundance by Region") +
  theme(plot.title = element_text(hjust = 0.5))

#-----------------------------------#
# 02.2.0  CONTINUOUS VARIABLES      #
#-----------------------------------#

# kernel density plot

# HP
ggplot(pokemon, aes(x=Hp)) + 
       geom_density(color="darkblue", fill="gold2", alpha=0.7) +
       labs(title = "Pokémon life points",x="HP",y="Density")+
       theme(plot.title = element_text(hjust = 0.5))

# Height
ggplot(pokemon, aes(x=Height_m)) + 
       geom_density(color="darkblue", fill="gold2", alpha=0.7) +
       labs(title = "Pokémon height",x="Height (m)",y="Density")+
       theme(plot.title = element_text(hjust = 0.5))

# Weight
ggplot(pokemon, aes(x=Weight_Kg)) + 
       geom_density(color="darkblue", fill="gold2", alpha=0.7) +
       labs(title = "Pokémon weight",x="Weight (Kg)",y="Density")+
       theme(plot.title = element_text(hjust = 0.5))
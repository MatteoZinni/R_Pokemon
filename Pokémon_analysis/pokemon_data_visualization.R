# import dataset
pokemon = read.csv(file.choose(), dec = ".")

# set functions folder
functions_folder = "F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_Pokémon/R_Pokemon/Pokémon_functions"

# loading libraries
library(ggplot2)

# check df
head(pokemon)

# check structure
str(pokemon)

# check size
dim(pokemon)

# data editing 

# remove japanese name column
pokemon = pokemon[,-30]

# make the the first letter capital
headers = gsub("(?<=^|_)([a-z])", "\\U\\1", colnames(pokemon), perl=TRUE)

# replace headers
colnames(pokemon) = headers

# edit some variables names to look smarter
colnames(pokemon)[28] <- "Height_m"
colnames(pokemon)[36] <- "Type_1"
colnames(pokemon)[37] <- "Type_2"

# edit generation name to display roman numeral
Generation = factor(pokemon$Generation, levels=c(1:7), labels = as.roman(c(1:7)))

# replace column
pokemon$Generation <- Generation

# add region using assign_region function

# sourcing 
source(paste(functions_folder, "pokemon_functions.R", sep = '/'))

# running function
pokemon$Region = as.factor(assign_region(pokemon))


# 01 overall abundance by region

# starting with a simple barplot to display
# pokèmon abundance by region
barplot(table(pokemon$Region), main = "Pokèmon abundance", xlab = "Regions", ylab = "Number of Pokèmon")
abline(h=0)

# plot the same data with a more nice looking barplot

# creating fist a df to pass to ggplot function
region_df = as.data.frame(table(pokemon$Region, dnn = "Region"), responseName = "Abundance")

# plot
ggplot(data=region_df, aes(x= reorder(Region, Abundance), y=Abundance, fill=Region)) +     
  geom_bar(stat="identity") +
  geom_text(aes(label=Abundance), vjust=1.6, color="Black", size=3.5) +
  xlab(label = "Regions") +
  ylab(label = "Number of Pokémon") +
  ggtitle(label = "Pokémon abundance by Region") +
  theme(plot.title = element_text(hjust = 0.5))

# 02 exploring pokémon type

# type 1 
type_1_df = as.data.frame(table(pokemon$Type_1,pokemon$Region, dnn = c("Type_1", "Region")), responseName = "Abundance")

# make first letter uppercase
type_1_df$Type_1 = as.factor(gsub("(?<=^|_)([a-z])", "\\U\\1", type_1_df$Type_1, perl=TRUE))

# creating color vector with proper color
pokemon_type_1_color = c("yellowgreen", "gray25", "lightslateblue", "orange", "orchid1", "chocolate4", "red1", "steelblue2", "royalblue3",
                         "chartreuse2", "lightgoldenrod3", "cadetblue1", "cornsilk3", "magenta4","maroon2", "khaki4", "grey69", "dodgerblue" )

# plot
ggplot(type_1_df, aes(y = Abundance, x = Type_1 , fill = Type_1 )) + 
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5), plot.title = element_text(hjust = 0.5))+
  guides(fill=guide_legend(title="Type 1")) + 
  geom_bar(stat = 'identity') + facet_grid(Region ~.) + 
  labs(title = "Type Of Pokemon Over Regions",x="Type",y="Number of Pokèmon") +
  scale_fill_manual(values = pokemon_type_1_color)

# type 2: it can also be null
type_2_df = as.data.frame(table(pokemon$Type_2,pokemon$Region, dnn = c("Type_2", "Region")), responseName = "Abundance")

# assign level to null
levels(type_2_df$Type_2)[1] <- "none"

# make first letter uppercase
type_2_df$Type_2 = as.factor(gsub("(?<=^|_)([a-z])", "\\U\\1", type_2_df$Type_2, perl=TRUE))

levels(type_2_df$Type_2)

# creating color vector with proper color
pokemon_type_2_color = c("yellowgreen", "gray25", "lightslateblue", "orange", "orchid1", "chocolate4", "red1", "steelblue2", "royalblue3",
                         "chartreuse2", "lightgoldenrod3", "cadetblue1", "slategray","cornsilk3", "magenta4","maroon2", "khaki4", "grey69", "dodgerblue" )

# plot
ggplot(type_2_df, aes(y = Abundance, x = Type_2 , fill = Type_2 )) + 
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5), plot.title = element_text(hjust = 0.5))+
  guides(fill=guide_legend(title="Type 2")) + 
  geom_bar(stat = 'identity') + facet_grid(Region ~.) + 
  labs(title = "Type Of Pokemon Over Regions",x="Type",y="Number of Pokèmon") +
  scale_fill_manual(values = pokemon_type_2_color)

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

# calculating percentage within type 2
type_2_df$Relative_abundance = round(((type_2_df$Abundance/rep(region_df$Abundance, each = length(levels(type_2_df$Type_2))))*100),2)

# plot
ggplot(type_2_df, aes(y = Relative_abundance, x = Type_2 , fill = Type_2 )) + 
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=0.5), plot.title = element_text(hjust = 0.5))+
  guides(fill=guide_legend(title="Type 2")) + 
  geom_bar(stat = 'identity') + facet_grid(Region ~.) + 
  labs(title = "Type Of Pokemon Over Regions",x="Type",y="Type composition as percentage") +
  scale_fill_manual(values = pokemon_type_2_color)


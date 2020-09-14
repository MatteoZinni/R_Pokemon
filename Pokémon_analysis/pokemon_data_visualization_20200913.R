# import dataset
pokemon = read.csv(file.choose(), dec = ".")

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



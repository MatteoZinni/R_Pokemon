# loading FAOSTAT library
library(FAOSTAT)

# setting urls to retrieve data
url_bulk_site      <- "http://fenixservices.fao.org/faostat/static/bulkdownloads"
url_crops          <- file.path(url_bulk_site, "Production_Crops_E_All_Data.zip")
url_fertilizers    <- file.path(url_bulk_site, "Environment_Fertilizers_E_All_Data.zip")

setwd("F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_FAO")

# Create a folder to store the data
data_folder = "F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_FAO/FAO_data/FAO_data_base"

# Download the files
download_faostat_bulk(url_bulk = url_fertilizers, data_folder = data_folder)
download_faostat_bulk(url_bulk = url_crops, data_folder = data_folder)


production_crops <- read_faostat_bulk("FAO_data/FAO_data_base/Production_Crops_E_All_Data.zip")
env_fertilizers  <- read_faostat_bulk("FAO_data/FAO_data_base/Environment_Fertilizers_E_All_Data.zip")

crops_harvested = subset(production_crops, production_crops$element == "Area harvested")
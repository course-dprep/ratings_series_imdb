#First file to call for in makefile
#This file will extract the needed data and save it in a data sourcemap

library(here)
library(readr)

# Create a relative data directory
if (!dir.exists(here("Data"))) {
  dir.create(here("Data"))
}

# Define file paths for saving data 
ratings_path <- here("Data", "rating.tsv.gz")
basics_path  <- here("Data", "basics.tsv.gz")
episode_path <- here("Data", "episode.tsv.gz")

# Download data files
download.file("https://datasets.imdbws.com/title.ratings.tsv.gz", ratings_path)
download.file("https://datasets.imdbws.com/title.basics.tsv.gz", basics_path)
download.file("https://datasets.imdbws.com/title.episode.tsv.gz", episode_path)

# Reading the compressed files directly
Ratings_Data <- read_delim(gzfile(ratings_path), delim = "\t")
Genre_Data   <- read_delim(gzfile(basics_path), delim = "\t")
Episode_Data <- read_delim(gzfile(episode_path), delim = "\t")

#Previewing the data
summary(Ratings_Data)
summary(Genre_Data)
summary(Episode_Data)

print('file 1 run')

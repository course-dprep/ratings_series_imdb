### Setup ###
#Loading packages
library(here)
library(readr)

# Create a relative data directory
if (!dir.exists(here("Data"))) {
  dir.create(here("Data"))
}
print('Data saving location created')

# Define file paths for saving data 
ratings_path <- here("Data", "rating.tsv.gz")
genre_path  <- here("Data", "basics.tsv.gz")
episode_path <- here("Data", "episode.tsv.gz")


### Input ###
# Download data files
print('Downloading ratings, genre and episode zipfile and saving to Data file')
download.file("https://datasets.imdbws.com/title.ratings.tsv.gz", ratings_path)
download.file("https://datasets.imdbws.com/title.basics.tsv.gz", genre_path)
download.file("https://datasets.imdbws.com/title.episode.tsv.gz", episode_path)
print('Downloading complete')


### Transformation ###
# Reading the compressed files directly
print('loading the zipfiles ratings, genre and episode as dataframes')
Ratings_Data <- read_delim(gzfile(ratings_path), delim = "\t")
Genre_Data   <- read_delim(gzfile(genre_path), delim = "\t")
Episode_Data <- read_delim(gzfile(episode_path), delim = "\t")


### Output ###
# Saving the data frames as .csv files
print('Creating ratings-, genre- and episode_data.csv and saving to Data file')
write_csv(Ratings_Data, here("Data", "ratings_data.csv"))
write_csv(Genre_Data, here("Data", "genre_data.csv"))
write_csv(Episode_Data, here("Data", "episode_data.csv"))
print('CSV files created')
### Setup ###
#Loading packages
library(dplyr)
library(tidyverse)
library(ggplot2)
library(here)
library(readr)

# Creating the directory for output files
output_dir <- here("Gen", "data_preparation", "output")
# Check whether the directory already exists
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE) 
}
print('Gen/data_preparation/output saving location created')


### Input ###
# Reading the datasets into the workspace
Episode_Data <- read_csv("Data/episode_data.csv")
Genre_Data <- read_csv("Data/genre_data.csv")
Ratings_Data <- read_csv("Data/ratings_data.csv")


### Transformation ###
print('Combining the datasets and renaming columns, deleting unused variables, filtering series and episode on votes: NA')
# Combine datasets into one
raw_data <- Episode_Data %>%
  left_join(Genre_Data, by = "tconst") %>%
  left_join(Ratings_Data, by = "tconst")
print('Episode, Genre and Ratings data combined in dataframe raw_data')

# Filter out unused variables
selected_columns = raw_data %>% select(-titleType, -primaryTitle, -originalTitle)
print('unused variables deleted')

# Filter out episodes with NA or less than 206 (the mean) votes
filtered_data = selected_columns %>% filter(numVotes >=206)
print('series and episode votes: NA filtered')

# Change column names
colnames(filtered_data) = c( "episode_id", "show_id", "season_number", "episode_number", "is_for_adult", "start_year", "end_year", "episode_minutes", "genres", "rating", "n_votes")
print('Raw_data is cleaned')


### Output ###
# Saving the alterations to a new file called cleaned_data.csv
print('Creating cleaned_data.csv')
write_csv(filtered_data, here("Gen", "data_preparation", "output", "cleaned_data.csv"))
print('cleaned_data.csv file created')
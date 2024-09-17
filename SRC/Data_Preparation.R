#Third file in the makefile
#This file will clean the extracted information, hence it can be used in the analysis
library(dplyr)
library(tidyverse)
library(ggplot2)
library(here)

# Creating the directory for output files
output_dir <- here("gen", "data_preparation", "output")
# Check whether the directory already exists
if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE) 
}

# Combine datasets into one
raw_data <- Episode_Data %>%
  left_join(Genre_Data, by = "tconst") %>%
  left_join(Ratings_Data, by = "tconst")

# Filter out unused variables
selected_columns = raw_data %>% select(-titleType, -primaryTitle, -originalTitle)

# Filter out TV shows that have episodes with NA or less than 206 (the mean) votes
filtered_data <- selected_columns %>%
  group_by(parentTconst) %>%                                         # Group by TV show
  filter(all(numVotes >= 206) & all(episodeNumber != "\\N") & all(seasonNumber != "\\N")) %>%  # Keep only shows where all episodes meet the conditions
  ungroup()                                                          # Ungroup the data for further operations

# Change column names
colnames(filtered_data) = c( "episode_id", "show_id", "season_number", "episode_number", "is_for_adult", "start_year", "end_year", "episode_minutes", "genres", "rating", "n_votes")

write.csv(filtered_data, here("gen", "data_preparation", "output", "cleaned_data.csv"), row.names = FALSE)

print('file 3 run')
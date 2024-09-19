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

# Filter out episodes with NA or less than 206 (the mean) votes
filtered_data = selected_columns %>% filter(numVotes >=206)

# Change column names
colnames(filtered_data) = c( "episode_id", "show_id", "season_number", "episode_number", "is_for_adult", "start_year", "end_year", "episode_minutes", "genres", "rating", "n_votes")

# Creating the independent variable for the linear regression
# Converting episode_minutes from character to numeric values
filtered_data$episode_minutes <- as.numeric(as.character(filtered_data$episode_minutes))

# Arranging by series, season number, and episode number
filtered_data <- filtered_data %>%
  arrange(show_id, season_number, episode_number)

# Calculating the cumulative runtime within each series and season
filtered_data <- filtered_data %>%
  group_by(show_id, season_number) %>%
  mutate(season_runtime = cumsum(episode_minutes) - episode_minutes)

# Calculating the total runtime of previous seasons within series
filtered_data <- filtered_data %>%
  group_by(show_id) %>%
  mutate(prev_season_runtime = lag(cumsum(episode_minutes), default = 0))

# Create the totalSeries_Runtime variable
filtered_data <- filtered_data %>%
  mutate(series_runtime = season_runtime + prev_season_runtime)

write.csv(filtered_data, here("gen", "data_preparation", "output", "cleaned_data.csv"), row.names = FALSE)

print('file 3 run')
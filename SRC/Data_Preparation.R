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

# Filter out TV shows that have episodes with NA or less than 206 (the mean) votes
filtered_data <- selected_columns %>%
  group_by(parentTconst) %>%                                         # Group by TV show
  filter(all(numVotes >= 206) & all(episodeNumber != "\\N") & all(seasonNumber != "\\N")) %>%  # Keep only shows where all episodes meet the conditions
  ungroup()                                                          # Ungroup the data for further operations

# Change column names
colnames(filtered_data) = c( "episode_id", "show_id", "season_number", "episode_number", "is_for_adult", "start_year", "end_year", "episode_minutes", "genres", "rating", "n_votes")
print('Raw_data is cleaned')

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

### Output ###
# Saving the alterations to a new file called cleaned_data.csv
print('Creating cleaned_data.csv')
write_csv(filtered_data, here("Gen", "data_preparation", "output", "cleaned_data.csv"))
print('cleaned_data.csv file created')
# Loading necessary libraries
library(dplyr)
library(tidyverse)
library(here)
library(readr)

# Define a function for processing the data
process_data <- function(episode_file, genre_file, ratings_file, output_dir) {
  
  # Create the output directory if it doesn't exist
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
    print(paste(output_dir, "saving location created"))
  }
  
  # Reading datasets
  episode_data <- read_csv(episode_file)
  genre_data <- read_csv(genre_file)
  ratings_data <- read_csv(ratings_file)
  
  # Combining datasets and filtering data
  filtered_data <- episode_data %>%
    left_join(genre_data, by = "tconst") %>%
    left_join(ratings_data, by = "tconst") %>%
    select(-titleType, -primaryTitle, -originalTitle) %>%
    group_by(parentTconst) %>%
    filter(all(numVotes >= 206) & all(episodeNumber != "\\N") & all(seasonNumber != "\\N")) %>%
    ungroup() %>%
    # Renaming columns
    rename(episode_id = tconst,
           show_id = parentTconst,
           season_number = seasonNumber,
           episode_number = episodeNumber,
           is_for_adult = isAdult,
           start_year = startYear,
           end_year = endYear,
           episode_minutes = runtimeMinutes,
           genres = genres,
           rating = averageRating,
           n_votes = numVotes) %>%
    # Converting episode_minutes to numeric
    mutate(episode_minutes = as.numeric(as.character(episode_minutes)))
  
  # Remove all episodes under the same show_id if any episode in the show has NA in episode_minutes
  filtered_data <- filtered_data %>%
    group_by(show_id) %>%
    filter(!any(is.na(episode_minutes))) %>%  # Remove entire show if any episode has NA in episode_minutes
    ungroup()
  
  # Sorting and calculating cumulative runtimes
  filtered_data <- filtered_data %>%
    arrange(show_id, season_number, episode_number) %>%
    group_by(show_id, season_number) %>%
    mutate(season_runtime = cumsum(episode_minutes) - episode_minutes) %>%
    group_by(show_id) %>%
    mutate(prev_season_runtime = lag(cumsum(episode_minutes), default = 0),
           series_runtime = season_runtime + prev_season_runtime)
  
  # Writing the cleaned data to CSV
  output_file <- file.path(output_dir, "cleaned_data.csv")
  write_csv(filtered_data, output_file)
  print(paste("cleaned_data.csv file created at", output_file))
}

# Call the function
process_data(
  episode_file = here("data", "episode_data.csv"),
  genre_file = here("data", "genre_data.csv"),
  ratings_file = here("data", "rating_data.csv"),
  output_dir = here("gen", "data_preparation", "output")
)

### Setup ###
#Loading packages
library(here)
library(readr)

# Function to handle downloading, reading, and saving data
download_and_process_data <- function(url, file_name, delim = "\t") {
  # Create a relative data directory if it doesn't exist
  if (!dir.exists(here("Data"))) {
    dir.create(here("Data"))
  }
  
  # Define the file path
  file_path <- here("Data", paste0(file_name, ".tsv.gz"))
  
  # Download the file
  download.file(url, file_path)
  print(paste(file_name, "file downloaded"))
  
  # Read the compressed file
  data <- read_delim(gzfile(file_path), delim = delim)
  print(paste(file_name, "data loaded into dataframe"))
  
  # Save the data as .csv
  csv_path <- here("Data", paste0(file_name, "_Data.csv"))
  write_csv(data, csv_path)
  print(paste(file_name, "data saved as CSV at", csv_path))
}

### Input / Transformation / Output ###
# Call the function for ratings, genre, and episode data
download_and_process_data("https://datasets.imdbws.com/title.ratings.tsv.gz", "Rating")
download_and_process_data("https://datasets.imdbws.com/title.basics.tsv.gz", "Genre")
download_and_process_data("https://datasets.imdbws.com/title.episode.tsv.gz", "Episode")

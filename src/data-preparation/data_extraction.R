# Loading packages
library(here)
library(readr)

# Function to handle downloading, reading, and saving data
download_and_process_data <- function(url, file_name, delim = "\t", data_dir = "data") {
  # Create a relative data directory if it doesn't exist
  if (!dir.exists(here(data_dir))) {
    dir.create(here(data_dir))
  }
  
  # Define the file path
  file_path <- here(data_dir, paste0(file_name, ".tsv.gz"))
  
  # Define the CSV path
  csv_path <- here(data_dir, paste0(file_name, "_data.csv"))
  
  # Check if the CSV file already exists
  if (file.exists(csv_path)) {
    print(paste(file_name, "data already exists as CSV. Skipping download and processing."))
  } else {
    # Download the file
    download.file(url, file_path)
    print(paste(file_name, "file downloaded"))
  
    # Read the compressed file
    data <- read_delim(gzfile(file_path), delim = delim)
    print(paste(file_name, "data loaded into dataframe"))
  
    # Save the data as .csv
    write_csv(data, csv_path)
    print(paste(file_name, "data saved as CSV at", csv_path))
  }
}

# Call the function for ratings, genre, and episode data
download_and_process_data("https://datasets.imdbws.com/title.ratings.tsv.gz", "rating")
Sys.sleep(2)
download_and_process_data("https://datasets.imdbws.com/title.basics.tsv.gz", "genre")
Sys.sleep(2)
download_and_process_data("https://datasets.imdbws.com/title.episode.tsv.gz", "episode")
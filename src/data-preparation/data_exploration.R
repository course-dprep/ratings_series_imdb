### Setup ###
# Loading libraries
library(dplyr)
library(ggplot2)
library(readr)
library(here)  # For dynamic file paths

# Function to load data, view structure, summary, head, and count NAs
process_datasets <- function(file_names, data_dir = "data", show = c("structure", "summary", "head", "na_counts")) {
  for (file_name in file_names) {
    # Construct file path using the here package
    file_path <- here(data_dir, file_name)
    
    # Load dataset
    data <- read_csv(file_path)
    
    cat("Processing file:", file_path, "\n\n")
    
    # Show structure
    if ("structure" %in% show) {
      cat("Structure:\n")
      str(data)
      cat("\n")
    }
    
    # Show summary statistics
    if ("summary" %in% show) {
      cat("Summary statistics:\n")
      print(summary(data))
      cat("\n")
    }
    
    # Show first few rows (head)
    if ("head" %in% show) {
      cat("First few rows:\n")
      print(head(data))
      cat("\n")
    }
    
    # Count missing values (counting \N as NA)
    if ("na_counts" %in% show) {
      cat("NA Counts:\n")
      na_counts <- sapply(data, function(x) sum(x == "\\N"))  # Count occurrences of \N
      
      # Create a clearer output format
      na_summary <- data.frame(
        Column = names(na_counts),
        NA_Count = na_counts
      )
      
      # Filter for columns with NA counts greater than 0
      na_summary <- na_summary[na_summary$NA_Count > 0, ]
      
      if (nrow(na_summary) == 0) {
        cat("No NA values found in this dataset.\n")
      } else {
        print(na_summary)
      }
      cat("\n")
    }
  }
}

### Input ###
# Example usage
file_names <- c("episode_data.csv", "genre_data.csv", "rating_data.csv")

### Transformation / Output ###
# You can specify what to show with the 'show' parameter.
# For example: process_datasets(file_names, show = c("structure", "summary", "head", "na_counts"))
# We are interested in the Na's, hence the following 'show' parameters:
process_datasets(file_names, show = c("head", "na_counts"))

#Second file to call for in makefile
#This file will be used to summarize the raw data 

### Setup ###
library(dplyr)
library(ggplot2)

### Input ###
Episode_Data <- read_csv("Data/episode_data.csv")
Genre_Data <- read_csv("Data/genre_data.csv")
Ratings_Data <- read_csv("Data/ratings_data.csv")

### Transformation ###
# View the structure of the data
str(Episode_Data)
str(Genre_Data)
str(Ratings_Data)

# View summary statistics
summary(Episode_Data)
summary(Genre_Data)
summary(Ratings_Data)

# View first few rows
head(Episode_Data)
head(Genre_Data)
head(Ratings_Data)

# Checking for NAs
# Define function to count the NAs
count_na_values <- function(data) {
  sapply(data, function(x) sum(x == "\\N"))
}

# Apply function to the data
episode_na_counts <- count_na_values(Episode_Data)
print(episode_na_counts)

genre_na_counts <- count_na_values(Genre_Data)
print(genre_na_counts)

ratings_na_counts <- count_na_values(Ratings_Data)
print(ratings_na_counts)

print('file 2 run')
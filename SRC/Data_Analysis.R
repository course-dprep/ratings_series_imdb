#The fourth file in the makefile
#This file will use the cleaned data from data_preparation to analyse what we want to know

print('file 4 run')


### Setup ###
library(readr)

### Input ###
cleaned_data <- read_csv("cleaned_data.csv")

### Transformation ###
model <- lm(rating ~ series_runtime, data = cleaned_data)
summary(model)

### Output ###
### Setup ###
library(readr)
library(here)

### Input ###
cleaned_data <- read_csv(here("gen", "data_preparation", "output", "cleaned_data.csv"))

### Transformation ###
model <- lm(rating ~ series_runtime, data = cleaned_data)
summary(model)

### Output ###

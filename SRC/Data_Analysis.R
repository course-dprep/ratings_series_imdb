### Setup ###
library(readr)

### Input ###
cleaned_data <- read_csv("cleaned_data.csv")

### Transformation ###
model <- lm(rating ~ series_runtime, data = cleaned_data)
summary(model)

### Output ###
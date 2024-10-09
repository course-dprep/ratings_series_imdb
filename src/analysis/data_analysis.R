### Setup ###
library(readr)
library(here)
library(dplyr)
library(broom)
library(knitr)
library(kableExtra) 

### Input ###
cleaned_data <- read_csv(here("gen", "data_preparation", "output", "cleaned_data.csv"))

### Transformation ###
# Create function to do the regression analysis and make a table for the report

run_regression_analysis <- function(cleaned_data) {
  model <- lm(rating ~ series_runtime, data = cleaned_data)
  
  # Extract a clean data frame of the results
  tidy_model <- tidy(model)
  
  # Generate a proper table for in the report
  tidy_table <- kable(
    tidy_model, 
    format = "html",
    caption = "Regression Analysis: Rating vs Series Runtime",
    col.names = c("Term", "Estimate", "Standard Error", "Statistic", "P-value")
  ) %>%
    kable_styling(full_width = FALSE, position = "center")
  
    return(tidy_table)
}

### Output ###
run_regression_analysis(cleaned_data)
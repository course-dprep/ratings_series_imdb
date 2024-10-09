---
title: "README"
output: pdf_document
date: "2024-09-10"
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```
# Impact of TV Show Length on Episode Ratings - A Study on IMDB Data

## Research Motivation
User ratings are found to be a key success factor of series and help production companies gain financial success (Hsu et al., 2014). As such, it is important to determine what factors influence these ratings, in order to develop series that are most likely to receive high ratings. The length of an individual episode is found to have a significant effect on the rating on that episode (Danaher et al., 2011). However, how the length of the complete series influences the rating of the episodes remains unexplored. This study fills this gap in the literature by exploring the following research question:

## Research Question

What is the effect of the length of a TV show on the average rating of the TV show episodes?

## Research Method

The chosen research method for the mentioned research question is a regression analysis. This research method will be suitable to investigate the relation between the following variables: the length of a TV show and the episode ratings. Performing a regression analysis allows us to determine if the length of a TV show significantly affects the ratings of its episodes and to learn more about the direction of the relationship.

To perform the regression analysis we will make use of the following data sets: 1. title.episode.tsv.gz a. To find the series and the episodes 2. title.ratings.tsv.gz a. Average rating of individual users combined 3. title.basics.tsv.gz a. Genre for cross reference


## Way of Deployment

The chosen way of deployment will be a HTML report. This was chosen to make a structured layout and to ensure consistency over multiple devices and platforms.

## Workflow

The following workflow will be performed in this research to ensure an automated and reproducible workflow: 
1. Data exploration
2. Data preperation
3. Analysis
4. Evaluation and deployment

## Repository Overview
Below, you find an overview of the directory structure and files of this project. 
```
│   .gitignore
│   LICENSE
│   makefile
│   README.md
│
├───data
│       basics.tsv.gz
│       episode.tsv.gz
│       episode_data.csv
│       genre_data.csv
│       rating.tsv.gz
│       ratings_data.csv
│
├───gen
│   ├───data_preparation
│   │   └───output
│   │           cleaned_data.csv
│   └───paper
│       └───output
│               data_deployment.html
│
└───src
    ├───data-preparation  
    │       data_exploration.R
    │       data_extraction.R
    │       data_preparation.R
    ├───analysis
    │       data_analysis.R
    └───paper
            data_deployment.Rmd
```
## Dependencies
To run this project, the following software needs to be installed:
- R and RStudio - [Follow these installation instructions](https://tilburgsciencehub.com/topics/computer-setup/software-installation/rstudio/r/)
- Make - [Follow these installation instructions](https://tilburgsciencehub.com/topics/automation/automation-tools/makefiles/make/)

## How to run this project
To replicate our workflow, please follow these instructions:
1. Fork this repository
2. Run the following code on your command line/terminal:
```
git clone https://github.com/{your username}/ratings_series_imdb.git
```
3. Run the following command in this newly created directory:
```
make
```
4. Install the following R packages:
```
packages <- c("dplyr", "tidyverse", "readr", "here", "tidyr", "broom", "kableExtra", "knitr", "ggplot2")

install.packages(packages)
```
## Explaining variables per variable dataset

Below you will find the variable names and variable descriptions per dataset.

### Ratings Dataset

| Variable Name   | Variable Description                                |
|-----------------|-----------------------------------------------------|
| tconst (string) | Alphanumeric unique identifier of the title         |
| averageRating   | Weighted average of all the individual user ratings |
| numVotes        | Number of votes the title has received              |

### Genre Dataset

| Variable Name          | Variable Description                                                                                       |
|------------------------|------------------------------------------------------------------------------------------------------------|
| tconst (string)        | Alphanumeric unique identifier of the title                                                                |
| titleType (string)     | The type/format of the title (e.g. movie, short, tvseries, tvepisode, video, etc)                          |
| primaryTitle (string)  | The more popular title / the title used by the filmmakers on promotional materials at the point of release |
| originalTitle (string) | Original title, in the original language                                                                   |
| isAdult (boolean)      | 0: non-adult title; 1: adult title                                                                         |
| startYear (YYYY)       | Represents the release year of a title. In the case of TV Series, it is the series start year              |
| endYear (YYYY)         | TV Series end year. ‘\\N’ for all other title types                                                        |
| runtimeMinutes         | Primary runtime of the title, in minutes                                                                   |
| genres (string array)  | Includes up to three genres associated with the title                                                      |

### Episode dataset

| Variable Name           | Variable Description                            |
|-------------------------|-------------------------------------------------|
| tconst (string)         | Alphanumeric identifier of episode              |
| parentTconst (string)   | Alphanumeric identifier of the parent TV Series |
| seasonNumber (integer)  | Season number the episode belongs to            |
| episodeNumber (integer) | Episode number of the tconst in the TV series   |

### Cleaned_data dataset

| Variable Name             | Variable Description                                                                          |
|---------------------------|-----------------------------------------------------------------------------------------------|
| episode_id (string)       | Alphanumeric identifier of episode                                                            |
| show_id (string)          | Alphanumeric identifier of the parent TV Series                                               |
| season_number (integer)   | Season number the episode belongs to                                                          |
| episode_number (integer)  | Episode number of the tconst in the TV series                                                 |
| is_for_adult (boolean)    |  0: non-adult title; 1: adult title                                                           |
| start_year (YYYY)         | Represents the release year of a title. In the case of TV Series, it is the series start year |
| end_year (YYYY)           | TV Series end year. ‘\\N’ for all other title types                                           |
| episode_minutes (integer) | Primary runtime of the title, in minutes                                                      |
| genres (string array)     | Includes up to three genres associated with the title                                         |
| rating (double)           | Weighted average of all the individual user ratings                                           |
| n_votes (integer)         | Number of votes the title has received                                                        |
| season_runtime (integer)  | Number of total minutes the tv show has aired                                                 |

## Results
The aim of this study was to explore the relationship between the length of a TV show and their average rating. Using a ggplot2 visualization, the analysis examined how TV show runtime impacted viewer evaluations.

The displayed results shows the relationship between episode runtime and ratings. This plot illustrates a positive correlation, suggesting that longer episodes tend to receive higher ratings on average. This increase in viewer satisfaction can possibly be explained by the fact that increased runtime may facilitate more comprehensive stroytelling and thus character exploration. 

The mentioned results contributed to the conclusion of the research question. To summarize, a longer TV show runtime can negatively effect the rating of the show. A shorter TV show runtime thus in general leads to a higher rating. 

## Reference List
- Danaher, P. J., Dagger, T. S., & Smith, M. S. (2011). Forecasting television ratings. International Journal of Forecasting, 27(4), 1215–1240. https://doi.org/10.1016/j.ijforecast.2010.08.002
- Hsu, P., Shen, Y., & Xie, X. (2014). Predicting Movies User Ratings with Imdb Attributes. In Lecture notes in computer science (pp. 444–453). https://doi.org/10.1007/978-3-319-11740-9_41

## Contributors
This repository is part of a project for the course Data Preparation and Workflow Management instructed by Hannes Datta at Tilburg University. The project was created by:

- [Jibbe Beerens](https://github.com/jibbebeer)
- [Tara Gijsbers](https://github.com/TaraGijsbers)
- [Julian Peters](https://github.com/JulianPetersIsCoding)
- [Iris Verzijl](https://github.com/irisverzijl)
- [Fleur de Wolf](https://github.com/FleurdeWolf)

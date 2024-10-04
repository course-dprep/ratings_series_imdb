#Made some explorations

# Install packages if needed (comment out if already installed)
# install.packages("dplyr")
# install.packages("ggplot2")
# install.packages("corrplot")

# Load the libraries
library(dplyr)
library(ggplot2)
library(corrplot)
library(readr)
library(tidyr)

# Load the cleaned dataset
data <- read_csv("../Gen/data_preparation/output/cleaned_data.csv")

### Distribution of ratings ###
ggplot(data, aes(x = rating)) + 
  geom_histogram(binwidth = 0.5, fill = "blue", color = "black") + 
  labs(title = "Distribution of Ratings", x = "Rating", y = "Frequency")


### Average rating by episode number ###
average_rating <- data %>%
  group_by(episode_number) %>%
  summarise(avg_rating = mean(rating, na.rm = TRUE))

ggplot(average_rating, aes(x = episode_number, y = avg_rating)) + 
  geom_line() + 
  labs(title = "Average Rating by Episode Number", x = "Episode Number", y = "Average Rating")

### Ratings by genre ###
# Split genres into separate entries for analysis
data_genres <- data %>%
  mutate(genres = strsplit(as.character(genres), ",")) %>%
  unnest(genres) %>%
  group_by(genres) %>%
  summarise(avg_rating = mean(rating, na.rm = TRUE), n = n())

ggplot(data_genres, aes(x = reorder(genres, avg_rating), y = avg_rating)) + 
  geom_bar(stat = "identity", fill = "lightblue") + 
  coord_flip() + 
  labs(title = "Average Rating by Genre", x = "Genre", y = "Average Rating")

### Correlation matrix ###
# Correlation matrix Changing axels?
cor_matrix <- cor(data %>% select(rating, n_votes, episode_minutes), use = "complete.obs")
# Print the correlation matrix
print(cor_matrix)
# Visualize the correlation matrix
corrplot(cor_matrix, method = "circle", title = "Correlation Matrix")
corrplot(cor_matrix, method = "color", type = "lower", tl.cex = 0.8, title = "Correlation Matrix", mar = c(0, 0, 2, 0))

### Linear regression model ###
model <- lm(rating ~ n_votes + episode_minutes, data = data)
print(model)

### Rating trend over time ###
ggplot(data, aes(x = start_year, y = rating)) + 
  geom_point() + 
  geom_smooth(method = "loess", se = FALSE, color = "blue") + 
  labs(title = "Rating Trend Over Time", x = "Start Year", y = "Rating")

### Votes Distribution by episode ###
ggplot(data, aes(x = episode_number, y = n_votes)) + 
  geom_bar(stat = "identity", fill = "darkgreen") + 
  labs(title = "Votes Distribution by Episode", x = "Episode Number", y = "Number of Votes")

### Seasonal Rating Trend ###
ggplot(data, aes(x = episode_number, y = rating, group = season_number, color = as.factor(season_number))) + 
  geom_line() + 
  labs(title = "Ratings Trend Over Episodes by Season", x = "Episode Number", y = "Rating", color = "Season Number")

### Relationship between runtime and ratings ###
ggplot(data, aes(x = episode_minutes, y = rating)) + 
  geom_point(alpha = 0.5) + 
  geom_smooth(method = "lm", se = FALSE, color = "red") + 
  labs(title = "Relationship Between Episode Runtime and Ratings", x = "Episode Runtime (minutes)", y = "Rating")

### Genre popularity (Votes vs Genre) ###
ggplot(data_genres, aes(x = reorder(genres, n), y = n)) + 
  geom_bar(stat = "identity", fill = "orange") + 
  coord_flip() + 
  labs(title = "Number of Votes by Genre", x = "Genre", y = "Number of Votes")

### cumulative runtime per season ###
cumulative_runtime <- data %>%
  group_by(season_number) %>%
  summarise(total_runtime = sum(episode_minutes, na.rm = TRUE))

ggplot(cumulative_runtime, aes(x = season_number, y = total_runtime)) + 
  geom_bar(stat = "identity", fill = "purple") + 
  labs(title = "Cumulative Runtime by Season", x = "Season Number", y = "Total Runtime (minutes)")

### Rating spread by season ###
ggplot(data, aes(x = as.factor(season_number), y = rating)) + 
  geom_boxplot() + 
  labs(title = "Rating Spread by Season", x = "Season", y = "Rating")

### Season-wise rating comparison ### #Combi with below!!!
season_avg_rating <- data %>%
  group_by(season_number) %>%
  summarise(avg_rating = mean(rating, na.rm = TRUE))

ggplot(season_avg_rating, aes(x = as.factor(season_number), y = avg_rating)) + 
  geom_bar(stat = "identity", fill = "steelblue") + 
  labs(title = "Average Rating by Season", x = "Season Number", y = "Average Rating")

### Rating variability across seasons ### #Combi with above!!!
rating_variability <- data %>%
  group_by(season_number) %>%
  summarise(sd_rating = sd(rating, na.rm = TRUE))

ggplot(rating_variability, aes(x = as.factor(season_number), y = sd_rating)) + 
  geom_bar(stat = "identity", fill = "coral") + 
  labs(title = "Rating Variability by Season", x = "Season Number", y = "Rating Standard Deviation")

### Relationship between votes and runtime ###
ggplot(data, aes(x = episode_minutes, y = n_votes)) + 
  geom_point(alpha = 0.5, color = "darkblue") + 
  geom_smooth(method = "lm", se = FALSE, color = "red") + 
  labs(title = "Votes vs Episode Runtime", x = "Episode Runtime (minutes)", y = "Number of Votes")

### Top rated episodes ###
top_episodes <- data %>%
  arrange(desc(rating)) %>%
  top_n(10, rating)

ggplot(top_episodes, aes(x = reorder(episode_id, rating), y = rating)) + 
  geom_bar(stat = "identity", fill = "darkorange") + 
  coord_flip() + 
  labs(title = "Top 10 Highest Rated Episodes", x = "Episode ID", y = "Rating")

### Episode length vs rating ###
ggplot(data, aes(x = episode_minutes, y = rating)) + 
  geom_point(alpha = 0.6, color = "blue") + 
  geom_smooth(method = "lm", se = FALSE, color = "red") + 
  labs(title = "Episode Length vs Rating", x = "Episode Length (minutes)", y = "Rating")

### Votes by season ###
season_votes <- data %>%
  group_by(season_number) %>%
  summarise(total_votes = sum(n_votes, na.rm = TRUE))

ggplot(season_votes, aes(x = as.factor(season_number), y = total_votes)) + 
  geom_bar(stat = "identity", fill = "dodgerblue") + 
  labs(title = "Total Votes by Season", x = "Season Number", y = "Total Votes")

### Rating trend within each season ###
ggplot(data, aes(x = episode_number, y = rating, group = season_number, color = as.factor(season_number))) + 
  geom_line() + 
  geom_point() + 
  labs(title = "Rating Trend Within Each Season", x = "Episode Number", y = "Rating", color = "Season Number") + 
  facet_wrap(~season_number, scales = "free_x")

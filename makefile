All: Data/ratings_data.csv Data/genre_data.csv Data/episode_data.csv Gen/data_preparation/output/cleaned_data.csv Gen/paper/output/Data_Deployment.html

Data/ratings_data.csv: SRC/Data_Extraction.R
	Rscript SRC/Data_Extraction.R

Data/genre_data.csv: SRC/Data_Extraction.R
	Rscript SRC/Data_Extraction.R

Data/episode_data.csv: SRC/Data_Extraction.R
	Rscript SRC/Data_Extraction.R

Gen/data_preparation/output/cleaned_data.csv: SRC/Data_Preparation.R
	Rscript SRC/Data_Preparation.R

Gen/paper/output/Data_Deployment.html: SRC/Data_Deployment.Rmd
	if not exist Gen\paper mkdir Gen\paper
	if not exist Gen\paper\output mkdir Gen\paper\output
	Rscript -e "rmarkdown::render('SRC/Data_Deployment.Rmd', output_dir = 'Gen/paper/output')"

clean: 
	Rscript -e "unlink('Data', recursive = TRUE)"
	Rscript -e "unlink('Gen', recursive = TRUE)"
All: data/ratings_data.csv data/genre_data.csv data/episode_data.csv gen/data_preparation/output/cleaned_data.csv gen/paper/output/data_deployment.html

data/ratings_data.csv: src/data-preparation/data_extraction.R
	Rscript src/data-preparation/data_extraction.R

data/genre_data.csv: src/data-preparation/data_extraction.R
	Rscript src/data-preparation/data_extraction.R

data/episode_data.csv: src/data-preparation/data_extraction.R
	Rscript src/data-preparation/data_extraction.R

gen/data_preparation/output/cleaned_data.csv: src/data-preparation/data_preparation.R
	Rscript src/data-preparation/data_preparation.R

gen/paper/output/data_deployment.html: src/paper/data_deployment.Rmd
	if not exist gen\paper mkdir gen\paper
	if not exist gen\paper\output mkdir gen\paper\output
	Rscript -e "rmarkdown::render('src/paper/data_deployment.Rmd', output_dir = 'gen/paper/output')"

clean: 
	Rscript -e "unlink('data', recursive = TRUE)"
	Rscript -e "unlink('gen', recursive = TRUE)"
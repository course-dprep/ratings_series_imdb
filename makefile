All: Data/ratings_data.csv Data/genre_data.csv Data/episode_data.csv Gen/data_preparation/output/cleaned_data.csv SRC/Data_Deployment.html

Data/ratings_data.csv: SRC/Data_Extraction.R
	R --vanilla < SRC/Data_Extraction.R

Data/genre_data.csv: SRC/Data_Extraction.R
	R --vanilla < SRC/Data_Extraction.R

Data/episode_data.csv: SRC/Data_Extraction.R
	R --vanilla < SRC/Data_Extraction.R

Gen/data_preparation/output/cleaned_data.csv: SRC/Data_Preparation.R
	R --vanilla < SRC/Data_Preparation.R

SRC/Data_Deployment.html: SRC/Data_Deployment.Rmd
	Rscript -e "rmarkdown::render('SRC/Data_Deployment.Rmd')"

clean zipfiles: 
	R -e "unlink('Data/*.gz')"
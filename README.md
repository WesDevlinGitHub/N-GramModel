# Predict Next Word Using N-Gram Model

**This is a simple shiny application created to predict the next word given the previous one, two, or three words of a given input.**  

<p text-align="center">
    <img src="https://github.com/WesDevlinGitHub/jhu_final/blob/main/data/image.jpg" width="800"/>
</p>

## Setup

1. git clone repo

2. ensure you have the `ngram.sqlite` file in the `./data/` folder

3. run the application

4. To create your own database remove ngram.sqlite and rerun data_clean and database_generate functions to insert new data into database

### File Structure 

**predict.R**: Primary functions used to take a given input, clean the data, and select the proper table from the database for retrival of the next word with the highest frequency given the previous 1,2,3 words.

**data_clean.R**: Functions to read in a given set of `*.txt` documents and clean each row.  

**database_generate.R**: Helper functions and statements to insert cleaned tokenized n-grams into individual tables.  

**plot.R**: Generate Plots to support exploratory analysis of cleaned data

**ngram.R**: ngram tokenize and create a dataframe of a given min, max input for words/frequency

**ui.R**: Simple ui to dispay the app for a user

**server.R**: server backend to render the predicted word of a given reactive input

**ngram.sqlite**: database of stored tokenized ngrams. datebase has 3 tables each with 2 columns (Word, Frequency)





# Predict Next Word Using N-Gram Model

<p text-align="center">
    <img src="https://github.com/WesDevlinGitHub/jhu_final/blob/main/data/image.jpg" width="800"/>
</p>

**This is a simple shiny application created to predict the next word given the previous one, two, or three words of a given input.**  

A library for creating the Artemis Dash application, which standardizes, visualizes, and analyzes temporal geospatial data. Users can filter their search query and view data on different types of maps. Other types of geospatial data can be overlayed (such as Team Reports from exercises) to provide additional context.

## Setup

1. git clone repo

2. ensure you have the `ngram.sqlite` file in the `./data/` folder

3. run the application

### File Structure 

**predict.R**: Primary functions used to take a given input, clean the data, and select the proper table from the database for retrival of the next word with the highest frequency given the previous 1,2,3 words.

**data_clean.R**: Functions to read in a given set of `*.txt` documents and clean each row.  

**database_generate.R**: Helper functions and statements to insert cleaned tokenized n-grams into individual tables.  

**plot.R**: Generate Plots to support exploratory analysis of cleaned data

**ngram.R**: ngram tokenize and create a dataframe of a given min, max input for words/frequency

**ui.R**: Simple ui to dispay the app for a user

**server.R**: server backend to render the predicted word of a given reactive input

**ngram.sqlite**: database of stored tokenized ngrams. datebase has 3 tables each with 2 columns (Word, Frequency)





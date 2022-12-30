source('library.R')
source('./functions/ngram.R')

dfNgrams <- list(dfNgrams)
# Connect to the database
conn <- dbConnect(SQLite(), "./data/ngram.sqlite")

insert_data <- function(connection, df){
  #' Insert Data
  #'
  #' @param connection DB Connection 
  #' @param df dataframe to insert into database
  #'
  #' @return None
  #' Write a row of text data from a data frame to the database. Use this function
  #' to store initial lines of a txt document from the return of dfNgrams from ngram.R
  for(k in 1:length(df)){
    dbWriteTable(connection, "row_text", df[[k]], append = TRUE)
  }
}
insert_data(conn, dfNgrams)
# List all the Tables
dbListTables(conn)
# Select random 100k rows from db from row_text table
df <- dbGetQuery(conn, "SELECT * 
  FROM row_text
LIMIT 100000 
OFFSET ABS(RANDOM()) % MAX((SELECT COUNT(*) FROM row_text), 100000)")
df_twoword <- tokenize_ngrams(df, 2, 2)
dbWriteTable(conn, "word2_freq", df_twoword, append = TRUE)
rm(df_twoword)
df_threeword <- tokenize_ngrams(df, 3, 3)
dbWriteTable(conn, "word3_freq", df_threeword, append = TRUE)
rm(df_threeword)
df_fourword <- tokenize_ngrams(df, 4, 4)
dbWriteTable(conn, "word4_freq", df_fourword, append = TRUE)
rm(df_fourword)

# Close the database connection
dbDisconnect(conn)


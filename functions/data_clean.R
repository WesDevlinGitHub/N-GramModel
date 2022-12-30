source('library.R')
inputfolder <- "./data/"
pattern <- "*.txt"

merge_txt_files <- function(directory, pattern) {
  #' Combine Data
  #'
  #' @param directory(char): directory of file location
  #' @param n_lines(int): n lines to read in each file
  #' @param pattern(char): pattern of the file extension
  #'
  #' @return Merged n lines of each file in a directory
  #'
  inputfolder <- directory
  list <-
    list.files(inputfolder, pattern = pattern, full.names = TRUE)
  # Iterate through all files in directory and grab first 10 lines of each.
  results <- list()
  for (i in list) {
    filecon <- file(i)
    text <-
      readLines(filecon,
                skipNul = TRUE,
                encoding = 'UTF-8')
    results <- append(results, text)
    close(filecon)
  }
  # Get File size
  filesize <- format(object.size(results), units = 'Kb')
  # Get number of lines
  nolinesinfile <- length(results)
  # Total words
  filewordcount <- sum(stri_count_words(results))
  cat (
    "File Size: ",
    filesize,
    " Lines in File: ",
    nolinesinfile,
    " Words in File: ",
    filewordcount
  )
  return(results)
}

remove_chars <- function(x) {
  x <- gsub("[^a-z]", " ", x)
}


clean_data <- function(corpora) {
  #' Clean Corpus
  #'
  #' @param corpora(df): data frame to be cleaned
  #' 
  #' @return cleaned corpus of data removing punctuation, numbers etc.
  #' 
  corpora <- tm_map(corpora, removePunctuation)
  corpora <- tm_map(corpora, removeNumbers)
  corpora <- tm_map(corpora, content_transformer(tolower))
  corpora <- tm_map(corpora, content_transformer(remove_chars))
  corpora <- tm_map(corpora, removeWords, stopwords('SMART'))
  corpora <- tm_map(corpora, stripWhitespace)
  return(corpora)
}

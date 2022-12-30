source('./functions/data_clean.R')
word_clean <- function(sentence){
  #' Clean a sentence or word input
  #'
  #' @param sentence(char): given input from a user 
  #'
  #' @return cleaned word(s)
  #' @examples word_clean("playing baseball")
  if(identical(sentence, "")){
    value = "Please input word(s)"
  }  else {
    corpusfeed <- VCorpus(VectorSource(sentence))
    # Clean Corpus
    corpusfeed_cleaned <- clean_data(corpusfeed)
    dfNgrams <-
      data.frame(text = sapply(corpusfeed_cleaned, as.character),
                 stringsAsFactors = FALSE)
    value = ngram(dfNgrams[[1]][1])
  }
  return(value)
}

ngram <- function(word){
  #' N-Gram Model
  #'
  #' @param word(char): word_clean returned value 
  #'
  #' @return Returns the word with the highest frequency in the database of 
  #' the n-gram.
  conn <- dbConnect(SQLite(), "./data/ngram.sqlite")
  sentence_length <- strsplit(word, ' ')[[1]]
  if (length(sentence_length) > 3){
    word <- strsplit(word, ' ')[[1]] %>% tail(3)
    word <- paste(word,collapse=' ')
  }
  if (length(sentence_length) == 1){
    k <- dbSendQuery(conn, "SELECT * FROM word2_freq WHERE Word LIKE ?")
  } else if (length(sentence_length) == 2){
    k <- dbSendQuery(conn, "SELECT * FROM word3_freq WHERE Word LIKE ?")
  } else if (length(sentence_length) >= 3){
    k <- dbSendQuery(conn, "SELECT * FROM word4_freq WHERE Word LIKE ?")
  } else
    {return("Bad Query")
  }
  dbBind(k, list(paste0(word,'%')))
  data <- dbFetch(k)
  dbClearResult(k)
  if (nrow(data) == 0 || nrow(data[grepl(paste0("^",word," "), data$Word),]) == 0){
    word <- strsplit(word, ' ')[[1]] %>% tail(1)
    word <- paste(word,collapse=' ')
    k <- dbSendQuery(conn, "SELECT * FROM word2_freq WHERE Word LIKE ?")
    dbBind(k, list(paste0(word,'%')))
    data <- dbFetch(k)
    nodata <- "True"
    dbClearResult(k)
  } else{
    nodata <- "False"
  }
  if (nrow(data)> 0){
    data <- data[grepl(paste0("^",word," "), data$Word), ]
    if(nrow(data)> 0){
      m <- max(as.numeric(data$Frequency))
      next_word <- data$Word[data$Frequency==m] 
    } else return ("Please enter a different word or end sentence in a non-stopword")
  } else {
    return("unknown")
  }
  if (nodata == "True"){
    next_word <- unlist(strsplit(as.character(data$Word[data$Frequency==m])," "))[2]
  } else if (length(sentence_length) == 1){
    next_word <- unlist(strsplit(as.character(data$Word[data$Frequency==m])," "))[2]
  } else if (length(sentence_length) > 1 & length(sentence_length) < 3){
    next_word <- next_word[1]
    next_word <- unlist(strsplit(as.character(next_word)," "))[3]
  } else if (length(sentence_length) > 2 & length(sentence_length) < 4){
    next_word <- next_word[1]
    next_word <- unlist(strsplit(as.character(next_word)," "))[4]
  } else if (length(sentence_length) >=3){
    next_word <- next_word[1]
    next_word <- unlist(strsplit(as.character(next_word)," "))[4]
  }else {return("unknown")}
  dbDisconnect(conn)
  return (next_word)
}







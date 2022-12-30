source('./functions/data_clean.R')
word_clean <- function(sentence){
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
    print('in the if statement line 42')
    next_word <- unlist(strsplit(as.character(data$Word[data$Frequency==m])," "))[2]
  } else if (length(sentence_length) > 1 & length(sentence_length) < 3){
    print('in the elif statement line 45')
    next_word <- next_word[1]
    next_word <- unlist(strsplit(as.character(next_word)," "))[3]
  } else if (length(sentence_length) > 2 & length(sentence_length) < 4){
    print('in the elif statement line 49')
    next_word <- next_word[1]
    next_word <- unlist(strsplit(as.character(next_word)," "))[4]
  } else if (length(sentence_length) >=3){
    print('in the elif statement line 49')
    next_word <- next_word[1]
    next_word <- unlist(strsplit(as.character(next_word)," "))[4]
  }else {return("unknown")}
  dbDisconnect(conn)
  return (next_word)
}



word_clean("playing baseball")




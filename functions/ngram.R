source('./functions/data_clean.R')
source('./functions/plot.R')


tokenize_ngrams <- function(nGramsdf, n_min, n_max) {
  #' Tokenize NGrams
  #'
  #' @param nGramsdf 
  #' @param n_min(int): min value to assigned to Weka Control 
  #' @param n_max(int): max value to assigned to Weka Control 
  #'
  #' @return data frame of Ngrams with "Word" and "Frequency" columns
  nGramTokenize <-
    NGramTokenizer(nGramsdf, Weka_control(min = n_min, max = n_max))
  ngrams <- data.frame(table(nGramTokenize))
  ngrams <- ngrams[order(ngrams$Freq, decreasing = TRUE),]
  colnames(ngrams) <- c("Word", "Frequency")
  return(ngrams)
}

#Merge txt files from a given directory
combined_text <- merge_txt_files(inputfolder, pattern)
# Generate Volatile Corpora
corpusfeed <- VCorpus(VectorSource(combined_text))
# Clean Corpus
corpusfeed_cleaned <- clean_data(corpusfeed)
#Generate a wordcloudplot of based on word frequency

dfNgrams <-
  data.frame(text = sapply(corpusfeed_cleaned, as.character),
             stringsAsFactors = FALSE)

# Create a df of words and their frequency of the given min and max ngram
n_grams <- tokenize_ngrams(readfile, 1, 1)

uniGramTokenized <- dbGetQuery(conn, "SELECT * 
  FROM word_freq")
BiGramTokenized <- dbGetQuery(conn, "SELECT * 
  FROM word2_freq")



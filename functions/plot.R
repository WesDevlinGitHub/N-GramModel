
generate_wordcloud <-
  function(corpus_cleaned_data,
           min_freq,
           max_words,
           random_order) {
    #' Generate a wordcloud
    #'
    #' @param corpus_cleaned_data(df): dataframe of cleaned data 
    #' @param min_freq(int): min frequency to be considered for the wordcloud
    #' @param max_words(int): max frequency to be considered for the wordcloud
    #' @param random_order(bool): plot words in random order. If false,'
    #'  they will be plotted in decreasing frequency
    #'
    #' @return generate wordcloud
    docmatrix <- TermDocumentMatrix(corpus_cleaned_data)
    set.seed(123)
    corpusMatrix <- as.matrix(docmatrix)
    sortedMatrix <- sort(rowSums(corpusMatrix), decreasing = TRUE)
    corpusDF <-
      data.frame(word = names(sortedMatrix), freq = sortedMatrix)
    wordcloud <- wordcloud(
      words = corpusDF$word,
      freq = corpusDF$freq,
      min.freq = min_freq,
      max.words = max_words,
      random.order = random_order,
      rot.per = 0.35,
      colors = brewer.pal(8, 'Dark2')
    )
    return(wordcloud)
  }

barplot_ngrams <-
  function(tokenizedNGrams,
           color,
           x_axis_lab,
           y_axis_lab,
           slice,
           title) {
    
    #' Bar Plot Tokenized N-Grams Based on Frequency
    #'
    #' @param tokenizedNGrams(df): dataframe of tokenized n-grams 
    #' @param color(char): character color of plot ex.('blue') 
    #' @param x_axis_lab(char): name of x-label 
    #' @param y_axis_lab(char): name of y-label
    #' @param slice(int): 1:n number of barplots to display based on frequency 
    #' @param title(char): title of the Plot 
    #'
    #' @return barplot showing highest frequency of words in a given tokenized
    #' ngram from 1 to n where 1 is highest in the dataset.
    tokenizedNGrams <- tokenizedNGrams[slice,]
    tokenizedNGrams <-
      ggplot(tokenizedNGrams, aes(x = reorder(Word, Frequency), y = Frequency)) +
      geom_bar(stat = "identity", fill = color) + labs(x = x_axis_lab, y = y_axis_lab, title = title)
    return(tokenizedNGrams)
  }
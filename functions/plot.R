generate_wordcloud <-
  function(corpus_cleaned_data,
           min_freq,
           max_words,
           random_order) {
    #' Generate a wordcloud of the frequency of words seen from a cleaned corpus dataset
    #'
    #' Returns a wordcloud plot
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
    #' Generate a plot of a given tokenized n-gram
    tokenizedNGrams <- tokenizedNGrams[slice,]
    tokenizedNGrams <-
      ggplot(tokenizedNGrams, aes(x = reorder(Word, Frequency), y = Frequency)) +
      geom_bar(stat = "identity", fill = color) + labs(x = x_axis_lab, y = y_axis_lab, title = title)
    return(tokenizedNGrams)
  }
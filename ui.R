# Define UI for application
ui <-fluidPage(
  # Text input field
  theme = bslib::bs_theme(bootswatch = "darkly"),
  titlePanel("Predict Next Word Using N-Gram Model"),
  h3("Begin by typing a word or words."),
  p("As you type you will see the next word generated below. Try not to use stopwords such as he,is,at,at,the etc."),
  p("You can continue typing different words and depending on the number of words in the input, different types of n-grams will be used."),
  p("If you see 'Bad Query', 'Unknown', etc... don't worry! just input different words"),
  p("Example word(s): Baseball , President Barack"),
  textInput("input_text", "Enter a phrase:"),
  # Submit button
  textOutput("next_word")
)



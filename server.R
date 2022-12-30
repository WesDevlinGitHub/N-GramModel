source('./functions/predict.R')
# Function to generate n-grams and predict the next word
server <- function(input, output,session) {
  # Reactive expression that listens for submit button to be clicked
  result <- reactive({
    # Only execute when submit button is clicked
      wordproc(input$input_text)
  })
  
  # Render the predicted next word
  output$next_word <- renderText({
    result()
  })
}
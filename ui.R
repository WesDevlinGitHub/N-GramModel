# Define UI for application
ui <-fluidPage(
  # Text input field
  textInput("input_text", "Enter a phrase:"),
  # Submit button
  textOutput("next_word")
)



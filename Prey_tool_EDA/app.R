# Prey_species_tool
# A simple tool to query reported prey species for federally listed vertebrates within Central California
library(shiny)

library(tidyverse)
prey <- read_csv("tidy_prey.csv") %>% 
  select(listed_species, prey_diet_binomial) %>% 
  distinct()

# single selection
shinyApp(
  ui = fluidPage(
    varSelectInput("listed_species", "listed_species", prey),
    plotOutput("data")
  ),
  server = function(input, output) {
    output$data <- renderPlot({
      ggplot(mtcars, aes(!!input$listed_species)) + geom_text()
    })
  }
)
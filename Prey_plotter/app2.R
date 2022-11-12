# Prey_species_tool
# A simple tool to query reported prey species for federally listed vertebrates within Central California
library(shiny)
library(tidyverse)


prey <- read_csv("tidy_prey.csv") %>% 
  select(listed_species, prey_diet_binomial) %>% 
  group_by(listed_species, prey_diet_binomial) %>% 
  summarize(n = n())


# Define UI for application that draws a histogram
ui <- fluidPage(    
    
    # Give the page a title
    titlePanel("Prey item query tool for Central California listed vertebrates"),
    
    # Generate a row with a sidebar
    sidebarLayout(      
      
      # Define the sidebar with one input
      sidebarPanel(
        selectInput("listed", "listed species:", 
                    choices=prey$listed_species),
        hr(),
        helpText("Data from KNB")
      ),
      
      # Create a spot for the barplot
      mainPanel(
        plotOutput("preyplot")  
      )
      
    )
  )
# Define server logic required to draw a histogram
server <- function(input, output) {
    output$preyplot <- renderPlot({
      ggplot(prey[,input$listed], aes(prey_diet_binomial, n)) +
      geom_bar(stat="identity")
            
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

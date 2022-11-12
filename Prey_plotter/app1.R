# Prey_species_tool
# A simple tool to query reported prey species for federally listed vertebrates within Central California
library(shiny)
library(tidyverse)
#library(datasets)

prey <- read_csv("tidy_prey.csv") %>% 
  select(listed_species, prey_diet_binomial) %>% 
  group_by(listed_species, prey_diet_binomial) %>% 
  summarize(n = n()) #%>% 
  #pivot_wider(names_from = listed_species, values_from = n) %>% 
  #mutate_at(c(2:17), ~replace_na(.,0))




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
  
  # Fill in the spot we created for a plot
  output$preyplot <- renderPlot({
    
    # Render a barplot
    barplot(prey[,input$listed], 
            main=input$listed,
            ylab="frequency of reported prey",
            xlab="prey species")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)


## 
setwd("~/Desktop/first-shiny-app")
library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("One Hit Wonder Calculator"),
    sidebarPanel(
        h3('Inputs'),
        sliderInput("year_range", "Year Range", min = 1940, max = 2015, value = c(1980, 1989), sep = ''),
        sliderInput("onehit", "Weight of Biggest Hit", min = 0.5, max = 3, value = 1, ticks = FALSE),
        sliderInput("whole_catalog", "Weight of Artist's Entire Catalog", min = 0.5, max = 3, value = 1, ticks = FALSE)
    ),
    mainPanel(
        h3('Main Panel'),
        tableOutput('toponhw')
    )
    
))
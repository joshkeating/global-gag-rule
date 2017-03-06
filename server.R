
library(shiny)
library(dplyr)
library(plotly)

data <- read.csv("./data/sub-saharan-exposure-and-maternal-mortality", stringsAsFactors = FALSE)
colnames(data)[5] <- "Number_Abortions"

function(input, output, session) {
  
  
  p <- ggplot(data) +
    geom_smooth(method = "loess", se = FALSE, aes(x=Year, y=Number_Abortions, colour = Country)) + 
    labs(x = "Year", y = "Induced Abortion") + 
    ggtitle("Induced Abortion In Sub-Saharan African Countries") + 
    geom_vline(xintercept = 2001)
  
  
  
  output$plot <- renderPlotly({
    
    ggplotly(p)
    
  })
  
}
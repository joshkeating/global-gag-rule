
library(shiny)
library(dplyr)
library(plotly)

data <- read.csv("./data/sub-saharan-exposure-and-maternal-mortality", stringsAsFactors = FALSE)

function(input, output, session) {
  
  
  p <- ggplot(data, aes(x=Year)) +
    geom_smooth(method = "loess", aes(x=Year, y=Num.Ab, colour = Country, fill = Country)) +
    geom_point(aes(x=Year, y=Num.Ab, colour=Country)) +
    labs(x = "Year", y = "abor") +
    ggtitle("title") + 
    geom_vline(xintercept = 2001)
  
  
  
  
  
  output$plot <- renderPlotly({
    # this is a plot
    
    ggplotly(p)
  })
  # 
}
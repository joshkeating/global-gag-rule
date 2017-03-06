
library(shiny)
library(dplyr)
library(plotly)

WHO.data <- read.csv("./data/sub-saharan-exposure-and-maternal-mortality", stringsAsFactors = FALSE)
colnames(WHO.data)[5] <- "Number_Abortions"

WHO.just.high <- WHO.data %>% filter(Exposure == "High")
WHO.just.low <- WHO.data %>% filter(Exposure == "Low")

function(input, output, session) {
  
  
  plot1 <- ggplot(WHO.data) +
    geom_smooth(method = "loess", se = FALSE, aes(x=Year, y=Number_Abortions, colour = Country)) + 
    labs(x = "Year", y = "Induced Abortion") + 
    ggtitle("Induced Abortion In Sub-Saharan African Countries") + 
    geom_vline(xintercept = 2001, linetype="dotted")

  # plot2 <- ggplot(NULL) +
  #   geom_smooth(data = WHO.just.high, method = "loess", se = FALSE, aes(x=Year, y=Number_Abortions)) + 
  #   geom_smooth(data = WHO.just.low, method = "loess", se = FALSE, aes(x=Year, y=Number_Abortions)) + 
  #   geom_smooth(data = WHO.data, method = "loess", se = FALSE, aes(x=Year, y=Number_Abortions)) + 
  #   labs(x = "Year", y = "Induced Abortion") + 
  #   ggtitle("high vs low exp") + 
  #   geom_vline(xintercept = 2001, linetype="dotted")
  
  plot2 <- ggplot(NULL) +
    geom_smooth(data = WHO.just.high, method = "loess", aes(x=Year, y=Number_Abortions)) + 
    geom_smooth(data = WHO.just.low, method = "loess", aes(x=Year, y=Number_Abortions)) + 
    geom_point(data = WHO.just.high, aes(x=Year, y=Number_Abortions, colour=Country)) + 
    labs(x = "Year", y = "Induced Abortion") + 
    ggtitle("high vs low exp") + 
    geom_vline(xintercept = 2001, linetype="dotted")
  
  plot3 <- ggplot(WHO.data) + 
    geom_smooth(method = "loess", aes(x=Year, y=Maternal_Mortality)) + 
    geom_jitter(aes(x=Year, y=Maternal_Mortality, colour=Country)) + 
     labs(x = "Year", y = "Maternal Mortality") + 
    ggtitle("Maternal Mortality In Sub-Saharan African Countries") + 
    geom_vline(xintercept = 2001, linetype="dotted")
  
  
  output$plot1 <- renderPlotly({
    ggplotly(plot1)
  })
  
  output$plot2 <- renderPlotly({
    ggplotly(plot2)
  })
  
  output$plot3 <- renderPlotly({
    ggplotly(plot3)
  })
  
}




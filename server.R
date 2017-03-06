
library(shiny)
library(dplyr)
library(plotly)

WHO.data <- read.csv("./data/sub-saharan-exposure-and-maternal-mortality", stringsAsFactors = FALSE)
colnames(WHO.data)[5] <- "Number_Abortions"

WHO.just.high <- WHO.data %>% filter(Exposure == "High")
WHO.just.low <- WHO.data %>% filter(Exposure == "Low")

function(input, output, session) {
  
  
  Who.by.country <- ggplot(WHO.data) +
    geom_smooth(method = "loess", se = FALSE, aes(x=Year, y=Number_Abortions, colour = Country)) + 
    labs(x = "Year", y = "Induced Abortion") + 
    ggtitle("Induced Abortion In Selected Sub-Saharan African Countries") + 
    geom_vline(xintercept = 2001, linetype="dotted") + 
    theme_bw()

  Who.by.exp <- ggplot(NULL) +
    geom_smooth(data = WHO.just.high, method = "loess", se = FALSE, aes(x=Year, y=Number_Abortions, colour = Exposure)) + 
    geom_smooth(data = WHO.just.low, method = "loess", se = FALSE, aes(x=Year, y=Number_Abortions, colour = Exposure)) + 
    geom_point(data = WHO.just.high, aes(x=Year, y=Number_Abortions, colour = Exposure)) + 
    geom_point(data = WHO.just.low, aes(x=Year, y=Number_Abortions, colour = Exposure)) + 
    labs(x = "Year", y = "Induced Abortion") +
    ggtitle("Comparing Abortion Rates In Countries With Both High And Low MCP Exposure") + 
    geom_vline(xintercept = 2001, linetype="dotted") + 
    theme_bw()
  
  Who.by.mm <- ggplot(WHO.data) + 
    geom_smooth(method = "loess", aes(x=Year, y=Maternal_Mortality)) + 
    geom_jitter(aes(x=Year, y=Maternal_Mortality, colour=Country)) + 
    labs(x = "Year", y = "Maternal Mortality per 100,000") + 
    ggtitle("Maternal Mortality In Selected Sub-Saharan African Countries") + 
    geom_vline(xintercept = 2001, linetype="dotted") + 
    theme_bw()
  
  
  output$plot1 <- renderPlotly({
    ggplotly(Who.by.exp)
  })
  
  output$plot2 <- renderPlotly({
    ggplotly(Who.by.country)
  })
  
  output$plot3 <- renderPlotly({
    ggplotly(Who.by.mm)
  })
  
}





library(shiny)
library(dplyr)
library(plotly)

WHO_data <- read.csv("./data/sub-saharan-exposure-and-maternal-mortality", stringsAsFactors = FALSE)
UN_data <- read.csv('./data/UN.csv', na.strings="..", stringsAsFactors = FALSE)
colnames(WHO_data)[5] <- "Number_Abortions"

UNyOpts1 <- c("CP_Any_Method", "CP_Any_Modern_Method", "CP_Any_Traditional_Method", "UN_Unmet_Need_Total", "Demand_Satisfied_By_Modern_Methods")
names(UNyOpts1) <- c("Contraceptive Prevalence", "Contraceptive (Modern) Prevalence", "Contraceptive (Traditional) Prevalence", "% with Unmet Needs for Family Planning", "Proportion of Family Planning Demand Satisfied via Modern Methods")
countries <- c("Angola", "Burundi", "Cape Verde", "Central African Republic", "Chad", "Comoros", "Djibouti", "Equatorial Guinea", "Eritrea", "Gabon", "Gambia", "Guinea-Bissau", "Liberia", "Mali", "Mauritania", "Sao Tome and Principe", "the Seychelles", "Somalia", "South Sudan", "Sudan", "Zimbabwe")


function(input, output, session) {
  
  
  
  africanData <- UN_data[UN_data$Country_Area %in% countries,] %>% filter(Population == "MW")
  Country <- factor(africanData$Country_Area)
  output$UNplot1 <- renderPlotly({
    
    Selected_Variable <- select(africanData, one_of(UNyOpts1[[input$y]]))
    
    UNviz1 <- ggplot(africanData, aes(x=Survey_End_Year, y = Selected_Variable, group=Country_Area)) + 
      geom_line(aes(colour= Country))+
      geom_point(aes(colour = Country))+
      geom_vline(xintercept = c(1984, 1993, 2001, 2009), linetype="dotted")
      labs(title = "Married/In-Union Women", x = "Year", y = input$y)

    ggplotly(UNviz1)
  })
  output$WHOplot1 <- renderPlotly({
    WHOviz <- ggplot(WHO_data) +
      geom_smooth(method = "loess", se = FALSE, aes(x=Year, y=Number_Abortions, colour = Country)) + 
      labs(x = "Year", y = "Induced Abortion") + 
      ggtitle("Induced Abortion In Sub-Saharan African Countries") + 
      geom_vline(xintercept = 2001, linetype="dotted")
    
    ggplotly(WHOviz)
  })
  
}

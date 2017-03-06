
library(shiny)
library(dplyr)

function(input, output, session) {
  UN_data <- read.csv('data/UN.csv', na.strings="..", stringsAsFactors = FALSE)
  
  output$UNplot <- renderPlot({
    Country <- factor(africanData$Country_Area)
    
    UNyOpts1 <- c("CP_Any_Method", "CP_Any_Modern_Method", "CP_Any_Traditional_Method", "UN_Unmet_Need_Total", "Demand_Satisfied_By_Modern_Methods")
    names(UNyOpts1) <- c("Contraceptive Prevalence", "Contraceptive (Modern) Prevalence", "Contraceptive (Traditional) Prevalence", "% with Unmet Needs for Family Planning", "Proportion of Family Planning Demand Satisfied via Modern Methods")
    Selected_Variable <- select(africanData, one_of(UNyOpts1[[input$y]]))
    
    UNviz <- ggplot(africanData, aes(x=Survey_End_Year, y = Selected_Variable, group=Country_Area)) + 
      geom_line(aes(colour= Country))+
      geom_point(aes(colour = Country))+
      annotate("rect", xmin = 1984, xmax = 1993, ymin=-Inf, ymax=Inf, alpha = .15)+
      annotate("rect", xmin = 2001, xmax = 2009, ymin=-Inf, ymax=Inf, alpha = .15)+
      labs(title = "Married/In-Union Women", x = "Year", y = input$y)

    
    print(UNviz)
  })
  
}

library(shiny)
library(dplyr)
library(plotly)

WHO_data <- read.csv("./data/sub-saharan-exposure-and-maternal-mortality", stringsAsFactors = FALSE)
UN_data <- read.csv('./data/UN.csv', na.strings="..", stringsAsFactors = FALSE)
aid_data <- read.csv('data/foreign-aid.csv', stringsAsFactors = FALSE)
colnames(WHO_data)[5] <- "Number_Abortions"

WHO.just.high <- WHO_data %>% filter(Exposure == "High")
WHO.just.low <- WHO_data %>% filter(Exposure == "Low")

UNyOpts1 <- c("CP_Any_Method", "CP_Any_Modern_Method", "CP_Any_Traditional_Method", "UN_Unmet_Need_Total", "Demand_Satisfied_By_Modern_Methods")
names(UNyOpts1) <- c("Contraceptive Prevalence", "Contraceptive (Modern) Prevalence", "Contraceptive (Traditional) Prevalence", "% with Unmet Needs for Family Planning", "Proportion of Family Planning Demand Satisfied via Modern Methods")
countries <- c("Angola", "Burundi", "Cabo Verde", "Central African Republic", "Chad", "Comoros", "Djibouti", "Equatorial Guinea", "Eritrea", "Gabon", "Gambia", "Guinea-Bissau", "Liberia", "Mali", "Mauritania", "Sao Tome and Principe", "the Seychelles", "Somalia", "South Sudan", "Sudan", "Zimbabwe")


function(input, output, session) {
  
  
  
  africanData <- UN_data[UN_data$Country_Area %in% countries,] %>% filter(Population == "MW")
  Country <- factor(africanData$Country_Area)
  output$UNplot1 <- renderPlotly({
    
    Selected_Variable <- select(africanData, one_of(UNyOpts1[[input$y]]))
    
    UNviz1 <- ggplot(africanData, aes(x=Survey_End_Year, y = Selected_Variable, group=Country_Area)) + 
      geom_line(aes(colour= Country))+
      geom_point(aes(colour = Country))+
      geom_vline(xintercept = c(1984, 1993, 2001, 2009), linetype="dotted")+
      labs(title = "Married/In-Union Women", x = "Year", y = input$y)

    ggplotly(UNviz1)
  })
  
  Who.by.exp <- ggplot(NULL) +
    geom_smooth(data = WHO.just.high, method = "loess", se = FALSE, aes(x=Year, y=Number_Abortions, colour = Exposure)) + 
    geom_smooth(data = WHO.just.low, method = "loess", se = FALSE, aes(x=Year, y=Number_Abortions, colour = Exposure)) + 
    geom_point(data = WHO.just.high, aes(x=Year, y=Number_Abortions, colour = Exposure)) + 
    geom_point(data = WHO.just.low, aes(x=Year, y=Number_Abortions, colour = Exposure)) + 
    labs(x = "Year", y = "Induced Abortion") +
    ggtitle("Comparing Abortion Rates In Countries With Both High And Low MCP Exposure") + 
    geom_vline(xintercept = 2001, linetype="dotted") + 
    theme_bw()
  
  Who.by.country <- ggplot(WHO_data) +
    geom_smooth(method = "loess", se = FALSE, aes(x=Year, y=Number_Abortions, colour = Country)) + 
    labs(x = "Year", y = "Induced Abortion") + 
    ggtitle("Induced Abortion In Selected Sub-Saharan African Countries") + 
    geom_vline(xintercept = 2001, linetype="dotted") + 
    theme_bw()
  
  Who.by.mm <- ggplot(WHO_data) + 
    geom_smooth(method = "loess", aes(x=Year, y=Maternal_Mortality)) + 
    geom_jitter(aes(x=Year, y=Maternal_Mortality, colour=Country)) + 
    labs(x = "Year", y = "Maternal Mortality per 100,000") + 
    ggtitle("Maternal Mortality In Selected Sub-Saharan African Countries") + 
    geom_vline(xintercept = 2001, linetype="dotted") + 
    theme_bw()
  
  output$WHOplot1 <- renderPlotly({
    ggplotly(Who.by.exp)
  })
  
  output$WHOplot2 <- renderPlotly({
    ggplotly(Who.by.country)
  })
  
  output$WHOplot3 <- renderPlotly({
    ggplotly(Who.by.mm)
  })
  
  output$aidplot1 <- renderPlotly({
    sum_by_NGO <- arrange(aggregate(as.numeric(aid_data$constant_amount), by=list(NGO_Name=aid_data$channel_name, NGO_ID=aid_data$channel_id), FUN=sum), desc(x))
    sum_by_NGO <- head(sum_by_NGO, 20)
    # first chart: rankings of all "health and population" NGOs by total disbursement
    # limit to top 20 NGOs
    p <- plot_ly(sum_by_NGO, type = "bar", x = sum_by_NGO$NGO_Name, y = sum_by_NGO$x)
  })
}

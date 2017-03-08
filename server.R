
library(shiny)
library(dplyr)
library(plotly)

function(input, output, session) {
  WHO_data <- read.csv("./data/sub-saharan-exposure-and-maternal-mortality", stringsAsFactors = FALSE)
  UN_data <- read.csv('./data/UN.csv', na.strings="..", stringsAsFactors = FALSE)
  aid_data <- read.csv('data/foreign-aid.csv', stringsAsFactors = FALSE)
  colnames(WHO_data)[5] <- "Number_Abortions"
  
  WHO.just.high <- WHO_data %>% filter(Exposure == "High")
  WHO.just.low <- WHO_data %>% filter(Exposure == "Low")
  
  UNyOpts1 <- c("CP_Any_Method", "CP_Any_Modern_Method", "CP_Any_Traditional_Method", "UN_Unmet_Need_Total", "Demand_Satisfied_By_Modern_Methods")
  names(UNyOpts1) <- c("Contraceptive Prevalence", "Contraceptive (Modern) Prevalence", "Contraceptive (Traditional) Prevalence", "% with Unmet Needs for Family Planning", "Proportion of Family Planning Demand Satisfied via Modern Methods")
  countries <- c("Angola", "Burundi", "Cabo Verde", "Central African Republic", "Chad", "Comoros", "Djibouti", "Equatorial Guinea", "Eritrea", "Gabon", "Gambia", "Guinea-Bissau", "Liberia", "Mali", "Mauritania", "Sao Tome and Principe", "the Seychelles", "Somalia", "South Sudan", "Sudan", "Zimbabwe")
  
  africanData <- UN_data[UN_data$Country_Area %in% countries,] %>% filter(Population == "MW")
  Country <- factor(africanData$Country_Area)
  output$UNplot1 <- renderPlotly({
    
    Selected_Variable <- select(africanData, one_of(UNyOpts1[[input$y]]))
    
    UNviz1 <- ggplot(africanData, aes(x=Survey_End_Year, y = Selected_Variable, group=Country_Area)) + 
      geom_line(aes(colour= Country))+
      geom_point(aes(colour = Country))+
      geom_vline(xintercept = c(1984, 1993, 2001, 2009), linetype="dotted")+
      labs(title = "Married/In-Union Women", x = "Year", y = input$y) +
      theme_bw()

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
  
  # data frames for aid data
  ngo_fp <- filter(aid_data, dac_purpose_name == "Family planning", channel_name %in% c("John Snow International", "Jhpiego Corporation"))
  yearly <- group_by(ngo_fp, channel_name, fiscal_year) %>% summarize(yearly_disbursements=sum(as.numeric(constant_amount))) %>% arrange(desc(yearly_disbursements))
  total <- summarize(yearly, total_disbursements=sum(as.numeric(yearly_disbursements)))
  
  output$aidplot1 <- renderPlotly({
    g <- ggplot(yearly, aes(x=fiscal_year, y=yearly_disbursements)) +
      scale_y_continuous(labels=dollar) +
      geom_point(aes(colour=channel_name)) +
      geom_line(aes(colour=channel_name)) +
      geom_vline(xintercept = c(2009), linetype="dotted") +
      labs(title = "U.S. Aid to NGOs for family planning", x = "Year", y = "Yearly Total Disbursement (USD)") +
      theme_bw() +
      theme(legend.position="none")
    ggplotly(g)
  })
}

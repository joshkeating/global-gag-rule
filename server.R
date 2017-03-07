
library(shiny)
library(dplyr)
library(plotly)
library(scales)

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
  
  # data for ngos providing family planning services
  ngo_fp <- filter(aid_data, dac_purpose_name == "Family planning")
  # disbursements for fp NGOs grouped by year
  yearly <- group_by(ngo_fp, NGO=channel_name, fiscal_year) %>% summarize(yearly_disbursements=sum(as.numeric(constant_amount))) %>% arrange(desc(yearly_disbursements))
  # total disbursement for fp ngos
  total <- summarize(yearly, total_disbursements=sum(as.numeric(yearly_disbursements)))
  # NGOs with the highest amount of total disbursement for family planning
  top_total <- arrange(total, desc(total_disbursements)) %>% head(10)
  # yearly disbursement for top NGOs
  top_yearly <- filter(yearly, NGO %in% unique(top_total$NGO))
  
  output$aidplot1 <- renderPlotly({
    g <- ggplot(top_yearly, aes(x=fiscal_year, y=yearly_disbursements)) +
      scale_y_continuous(labels=dollar) +
      geom_point(aes(colour=NGO)) +
      geom_line(aes(colour=NGO)) +
      geom_vline(xintercept = c(2009), linetype="dotted") +
      labs(title = "U.S. Aid to NGOs for family planning", x = "Fiscal Year", y = "Total Disbursement (USD)") +
      theme_bw() +
      theme(
        legend.position="bottom"
      )
    ggplotly(g)
  })
  
  # what other services do these NGO provide?
  # non family planning disbursements to the ngo selected from the above viz
  non_fp <- filter(aid_data, channel_name %in% unique(top_total$NGO))
  # non fp disbursements grouped by NGO, and summed by purpose for the selected ngo
  purpose_non_fp <- group_by(non_fp, NGO=channel_name, Purpose=dac_purpose_name) %>% summarize(purpose_disbursements=sum(as.numeric(constant_amount))) %>% arrange(desc(purpose_disbursements))
  # total non fp disbursements by purpose
  total_non_fp <- summarize(purpose_non_fp, total_disbursements=sum(as.numeric(purpose_disbursements)))
  
  output$aidplot2 <- renderPlotly({
    purpose_non_fp <- filter(purpose_non_fp, NGO == input$ngo) %>% transform(Purpose = reorder(Purpose, -purpose_disbursements))
    g <- ggplot(purpose_non_fp, aes(x=NGO, y=purpose_disbursements, fill=Purpose)) +
      geom_bar(stat="identity", position=position_dodge()) +
      scale_fill_hue(name="Purpose for disbursement") +
      scale_y_continuous(labels=dollar) +
      xlab("NGO") + ylab("Total disbursement (2001-2016)") +
      ggtitle("Related funding to notable family planning NGOs") +
      theme_bw() +
      theme(
        legend.position="bottom"
      )
    ggplotly(g)
  })
}

# investment in family planning increased under obama admin for notable NGOs
# what about totals for family planning? (regardless of NGO?) (maybe this should come first?)

# Outline of presentation:
# show growth in family planning funding (fp yearly totalled viz)
# show which NGOs saw growth under Obama (top 10 viz) (John snow is a notable example of huge increase)
# (maybe) show the number of NGOs engaging in FP work over time (plot number of NGOs over year) (GGR impacts many of these NGOs the hardest)
# illustrate how each NGO receives funding for other health related work (purpose bar chart per top 10 NGO)
# breakdown of funding by income area (bar chart?)
# links to NGOs statements on the issue (quote from FHOK, followed by quotes from John Snow about partners)
# how to support these organizations (links to donation, advocacy, petitions, call your senator etc.)
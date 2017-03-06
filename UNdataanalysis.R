library(dplyr)
library(ggplot2)
setwd("~/Documents/INFO498C/global-gag-rule")
UN_data <- read.csv('data/UN.csv', na.strings="..", stringsAsFactors = FALSE)

countries <- c("Angola", "Burundi", "Cape Verde", "Central African Republic", "Chad", "Comoros", "Djibouti", "Equatorial Guinea", "Eritrea", "Gabon", "Gambia", "Guinea-Bissau", "Liberia", "Mali", "Mauritania", "Sao Tome and Principe", "the Seychelles", "Somalia", "South Sudan", "Sudan", "Zimbabwe")

africanData <- UN_data[UN_data$Country_Area %in% countries,] %>% filter(Population == "MW")

# Unmet Need Total
Country <- factor(africanData$Country_Area)
ggplot(africanData, aes(x=Survey_End_Year, y = UN_Unmet_Need_Total, group=Country_Area)) + 
  geom_line(aes(colour= Country))+
  geom_point(aes(colour = Country))+
  annotate("rect", xmin = 1984, xmax = 1993, ymin=-Inf, ymax=Inf, alpha = .15)+
  annotate("rect", xmin = 2001, xmax = 2009, ymin=-Inf, ymax=Inf, alpha = .15)+
  labs(x = "Year", y = "% of Married Women With Unmet Need")

View(africanData %>% top_n(5, CP_Any_Method) %>% arrange(desc(CP_Any_Method)))

UNyOpts1 <- c("CP_Any_Method", "CP_Any_Modern_Method", "CP_Any_Traditional_Method", "UN_Unmet_Need_Total", "Demand_Satisfied_By_Modern_Methods")

names(UNyOpts1) <- c("Contraceptive Prevalence", "Contraceptive (Modern) Prevalence", "Contraceptive (Traditional) Prevalence", "% with Unmet Needs for Family Planning", "Proportion of Family Planning Demand Satisfied via Modern Methods")




library(dplyr)
library(ggplot2)
setwd("~/Documents/INFO498C/global-gag-rule")
UN_data <- read.csv('data/UN.csv')

UN_data[UN_data == '..'] <- NA

#test <- UN_data %>% filter(Country_Area == "Ecuador")

countries <- c("Angola", "Burundi", "Cape Verde", "Central African Republic", "Chad", "Comoros", "Djibouti", "Equatorial Guinea", "Eritrea", "Gabon", "Gambia", "Guinea-Bissau", "Liberia", "Mali", "Mauritania", "Sao Tome and Principe", "the Seychelles", "Somalia", "South Sudan", "Sudan", "Zimbabwe")

test <- UN_data[UN_data$Country_Area %in% countries,] %>% filter(Survey_End_Year > 1994)


ggplot(test, aes(x=Survey_End_Year)) + 
  geom_point(aes(y = CP_Any_Method, colour = factor(Country_Area)))

#+geom_smooth(aes(y = CP_Any_Method, colour = factor(Country_Area)),method=lm)
  

unique(UN_data$Age_Group)



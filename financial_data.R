library(dplyr)
library(ggplot2)

setwd("/Users/jlaws/school/info498/global-gag-rule")
funding_data <- read.csv("data/foreign-aid.csv")

# group rows by NGO (channel_id)
by_NGO <- group_by(funding_data, channel_id)

# sum of total aid funding going to each NGO
sum_by_NGO <- aggregate(as.numeric(data$constant_amount), by=list(funding_data$channel_id), FUN=sum)


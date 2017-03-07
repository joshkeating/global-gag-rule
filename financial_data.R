library(dplyr)
library(ggplot2)
library(scales)

setwd("/Users/jlaws/school/info498/global-gag-rule")
funding_data <- read.csv("data/foreign-aid.csv")

# group rows by NGO (channel_id)
by_NGO <- group_by(funding_data, channel_id)

# sum of total aid funding going to each NGO
# NOT filtered by "purpose"
sum_by_NGO <- arrange(aggregate(as.numeric(funding_data$constant_amount), by=list(NGO_Name=funding_data$channel_name, NGO_ID=funding_data$channel_id), FUN=sum), desc(x))

# names of all categories
distinct(funding_data, dac_purpose_name)

# first chart: rankings of all "health and population" NGOs by total disbursement
g <- ggplot(head(sum_by_NGO, 20), aes(NGO_Name, weight=x, fill=NGO_Name))

g + geom_bar() +
  scale_y_continuous(labels=comma) +
  theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))

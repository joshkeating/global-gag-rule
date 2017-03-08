library(dplyr)
library(ggplot2)
library(scales)

setwd("/Users/jlaws/school/info498/global-gag-rule")
aid_data <- read.csv("data/foreign-aid.csv")

# group rows by NGO (channel_id)
by_NGO <- group_by(aid_data, channel_id)

# sum of total aid funding going to each NGO
# NOT filtered by "purpose"
#sum_by_NGO <- arrange(aggregate(as.numeric(aid_data$constant_amount), by=list(NGO_Name=aid_data$channel_name, NGO_ID=aid_data$channel_id), FUN=sum), desc(x))

# names of all categories
# distinct(aid_data, dac_purpose_name)
ngo <- filter(aid_data, dac_purpose_name == "Family planning", channel_name %in% c("John Snow International", "Jhpiego Corporation"))
yeardata <- group_by(ngo, channel_name, fiscal_year) %>% summarize(yearly_disbursements=sum(as.numeric(constant_amount))) %>% arrange(desc(yearly_disbursements))
#total <- summarize(yearly, total_disbursements=sum(as.numeric(yearly_disbursements)))
#sum_ngo <- group_by(ngo_fp, channel_name, fiscal_year) %>% summarize(yearly_disbursements=sum(as.numeric(constant_amount))) %>% summarize(total_disbursements=sum(as.numeric(yearly_disbursements)))
#sum_ngo <- group_by(ngo_fp, NGO=channel_name, Year=fiscal_year) %>% summarize(total_disbursements=sum(as.numeric(constant_amount))) %>% arrange(desc(total_disbursements)) %>% head(10)

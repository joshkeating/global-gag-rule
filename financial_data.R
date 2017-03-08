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
all_yearly <- group_by(ngo_fp, fiscal_year) %>% summarize(yearly_disbursements=sum(as.numeric(constant_amount))) %>% mutate(NGO="Total (80 NGOs)")
all_count <- unique(ngo_fp$channel_id)

non_fp <- filter(aid_data, channel_name %in% unique(top_total$NGO))
# non fp disbursements grouped by NGO, and summed by purpose
purpose_non_fp <- group_by(non_fp, NGO=channel_name, Purpose=dac_purpose_name) %>% summarize(purpose_disbursements=sum(as.numeric(constant_amount))) %>% arrange(desc(purpose_disbursements))
# total non fp disbursements by purpose
total_non_fp <- summarize(purpose_non_fp, total_disbursements=sum(as.numeric(purpose_disbursements)))
# setwd("School_16-17/Q2/info498c/project/")

library(dplyr)
library(tidyr)

# data <- read.csv("UN.csv")
# 
who.data <- read.csv("needswork.csv")
# 
# # who.data <-  rename(who.data, X1994 == 1994)
# 
# tmp <- who.data %>% gather(Country, Obs, X1994:X2008)
# 
# # write.csv(tmp, file = "needswork.csv")
# 
# # tmp <- tmp %>% rename(Country1 == Country, Year == Country)
# # 
# # 
# # add.col <- substring(tmp[,4], 2)
# # add.col <- as.data.frame(add.col)
# 
# # tmp <- merge(tmp, add.col)

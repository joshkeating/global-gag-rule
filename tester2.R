# setwd("School_16-17/Q2/info498c/project/global-gag-rule/")

library(dplyr)
library(reshape2)
library(tidyr)

# data <- read.csv("data/UN.csv")

who.data <- read.csv("needswork.csv")

who.data <- who.data %>% rename(Year = Country.1)
who.data <- who.data %>% rename(Woman_years_and_num_abor = Obs.1)



who.data <- who.data %>% select(Country:Woman_years_and_num_abor)


just.b <- who.data %>% filter(Country == "Benin")

new.who <- read.csv("who-edited.csv")
new.who <- new.who %>% rename(Year = Country.1)
new.who <- new.who %>% select(Country, Eposure.to.Meico.City.Policy, Year, Num.Ab, woman.years)




# write.csv(new.who, file = "final-who.csv")



# write.csv(who.data, file = "curr-who.csv")

# R script for creating exploratory visualizations for the WHO dataset

# going to want to compare these data trends to the maternal mortality rate

# setwd("School_16-17/Q2/info498c/project/global-gag-rule/")

library(dplyr)
library(ggplot2)
library(tidyr)

who.data <- read.csv("data/final-who.csv")
# mm.data <- read.csv("data/maternal-mortality-WHO.csv")
new.mm.data <- read.csv("data/Maternal-Mortality-1994-2008.csv", check.names = FALSE)

just.high <- who.data %>% filter(Eposure.to.Meico.City.Policy == "High")


# this looks like a clear increase for post 2001 (george bush mexico city policy)

just.Malawi <- just.high %>% filter(Country == "Malawi")

Malawi.plot <- ggplot(just.Malawi, aes(x=Year)) +
  geom_smooth(method = "loess", aes(x=Year, y=Num.Ab, colour="#E69F00")) +
  geom_point(aes(x=Year, y=Num.Ab, colour="#E69F00")) +
  labs(x = "Year", y = "abor") +
  ggtitle("title") + 
  geom_vline(xintercept = 2001)

Malawi.plot

all.plot <- ggplot(just.high, aes(x=Year)) +
  geom_smooth(method = "loess", aes(x=Year, y=Num.Ab)) +
  geom_point(aes(x=Year, y=Num.Ab, colour=Country)) +
  labs(x = "Year", y = "abor") +
  ggtitle("title") + 
  geom_vline(xintercept = 2001)

all.plot

sub.countries <- just.high %>% distinct(Country)

# new.mm.data <- new.mm.data %>% rename(Country = Country Name)

# this is for the sake of time, I know it looks gross
just.sub.saharan <- new.mm.data %>% filter(Country == "Benin" | Country == "Ghana" |Country == "Guinea" |
                                             Country == "Madagascar" |Country == "Malawi" |Country == "Mali" |
                                             Country == "Mozambique" |Country == "Tanzania" |Country == "Benin")



# 
# all.plot <- ggplot(just.sub.saharan, aes(x=Year)) +
#   geom_smooth(method = "loess", aes(x=Year, y=Num.Ab)) +
#   geom_point(aes(x=Year, y=Num.Ab, colour=Country)) +
#   labs(x = "Year", y = "abor") +
#   ggtitle("title") + 
#   geom_vline(xintercept = 2001)
# 
# all.plot




























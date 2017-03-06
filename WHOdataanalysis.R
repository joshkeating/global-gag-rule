# R script for creating exploratory visualizations for the WHO dataset

# going to want to compare these data trends to the maternal mortality rate

#setwd("School_16-17/Q2/info498c/project/global-gag-rule/")

library(dplyr)
library(ggplot2)
library(tidyr)

who.data <- read.csv("data/final-who.csv")

# this set is limited and therefore not as useful
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
                                           Country == "Mozambique" |Country == "Tanzania" |Country == "Benin" |
                                           Country == "Zambia")


sub.saharan.long <- just.sub.saharan %>% gather(Country, Num_Ab, `1994`:`2008`)

colnames(sub.saharan.long)[2] <- "Year"

# sub.saharan.long$Year <- as.numeric(sub.saharan.long$Year)

sub.saharan.long$Year <- as.numeric(as.character(sub.saharan.long$Year))

# no obvious correlation here

sub.mm.plot <- ggplot(sub.saharan.long, aes(x=Year)) +
  geom_smooth(method = "loess", aes(x=Year, y=Num_Ab)) +
  geom_point(aes(x=Year, y=Num_Ab, colour=Country)) +
  labs(x = "Year", y = "abor") +
  ggtitle("title") +
  geom_vline(xintercept = 2001)

sub.mm.plot

# lm(mat.mort ~ policy.exposure + other.variables, data=your.df)
# lm documentation - https://stat.ethz.ch/R-manual/R-devel/library/stats/html/lm.html

# bingo
exposure.mm <- merge(just.high, sub.saharan.long)

exposure.mm <- exposure.mm %>% select(-X)

colnames(exposure.mm)[6] <- "Maternal_Mortality"

# need to do another regression with both high and low exposure to see effects

# lmfit <- lm(Maternal_Mortality ~ woman.years + Num.Ab, data=exposure.mm)

# plot(lmfit)

all.sub.countries <- who.data %>% distinct(Country)

list <- as.list(all.sub.countries$Country)

# I know, I know
all.mm <- new.mm.data %>% filter(Country == "Benin" | Country == "Burkina Faso" | Country == "Ethiopia" |
                                 Country == "Ghana" | Country == "Guinea" | Country == "Kenya" |
                                 Country == "Madagascar" | Country == "Malawi" | Country == "Mali" |
                                 Country == "Mozambique"| Country == "Niger" | Country == "Nigeria" |
                                 Country == "Rwanda" | Country == "Senegal" | Country == "Sierra Leone" |
                                 Country == "Swaziland" | Country == "Uganda" | Country == "Tanzania" |
                                 Country == "Zambia" | Country == "Zimbabwe")


all.mm.long <- all.mm %>% gather(Country, Num_Ab, `1994`:`2008`)

colnames(all.mm.long)[2] <- "Year"

full.exposure.mm <- merge(who.data, all.mm.long)

colnames(full.exposure.mm)[7] <- "Maternal_Mortality"

full.exposure.mm <- full.exposure.mm %>% select(-X)
colnames(full.exposure.mm)[3] <- "Exposure"



# lm(mat.mort ~ policy.exposure + other.variables, data=your.df)

# lmfit <- lm(Maternal_Mortality ~ Exposure + Num.Ab, data=full.exposure.mm, na.action = na.omit)
# lmfit
# preds <- predict(lmfit)
# plot(preds, full.exposure.mm$Maternal_Mortality[!is.na(full.exposure.mm$Num.Ab)])
# 
# summary(lmfit)
# lmfit2 <- lm(Year ~ Exposure + Maternal_Mortality, data=full.exposure.mm)

# plot(lmfit2)







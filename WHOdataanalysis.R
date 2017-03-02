# R script for creating exploratory visualizations for the WHO dataset

# going to want to compare these data trends to the maternal mortality rate

library(dplyr)
library(ggplot2)

who.data <- read.csv("data/final-who.csv")


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









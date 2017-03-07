
library(shiny)
library(dplyr)
library(plotly)

UNyOpts1 <- c("CP_Any_Method", "CP_Any_Modern_Method", "CP_Any_Traditional_Method", "UN_Unmet_Need_Total", "Demand_Satisfied_By_Modern_Methods")
names(UNyOpts1) <- c("Contraceptive Prevalence", "Contraceptive (Modern) Prevalence", "Contraceptive (Traditional) Prevalence", "% with Unmet Needs for Family Planning", "Proportion of Family Planning Demand Satisfied via Modern Methods")
countries <- c("Angola", "Burundi", "Cabo Verde", "Central African Republic", "Chad", "Comoros", "Djibouti", "Equatorial Guinea", "Eritrea", "Gabon", "Gambia", "Guinea-Bissau", "Liberia", "Mali", "Mauritania", "Sao Tome and Principe", "the Seychelles", "Somalia", "South Sudan", "Sudan", "Zimbabwe")


navbarPage("Global Gag Rule",
           
           tabPanel("Summary", 
                    verbatimTextOutput("summary")
           ),
           
           tabPanel("Viz 1",
                    titlePanel("Measuring Reproductive Health for Married/In-Union Women in Sub-Saharan African Countries"),
                    sidebarLayout(
                      sidebarPanel(
                        selectInput('y', 'Measure of Reproductive Health', names(UNyOpts1), names(UNyOpts1)[[1]])
                      ),
                      mainPanel(
                        plotlyOutput("UNplot1")
                      )
                    )
           ),
           
           tabPanel("Abortions and Maternal Mortality",
                    fluidPage(
                      
                      titlePanel("Induced Abortions and Maternal Mortality in Sub-Saharan African Countries"),
                      p("In approaching this analysis I needed to use some unconventional methods of data sourcing. For the 
                        data on induced abortions and exposure to the “Global Gag Rule” (GGR) I scraped a html table that the
                        WHO made available through the Stanford paper published on their website. Unfortunately for me, the
                        hierarchy of the table did not easily lend itself to reshaping in R so a considerable amount of work
                        was done to convert it into a long form csv file. I was curious about some of the potential public 
                        health effects that the ban could have had historically on an area such as maternal mortality. The
                        hypothesis that maternal mortality would be higher after the ban was instituted was based on my intuition.
                        I found a dataset from the World Health Organization covering maternal mortality rates from 1990 to 2015
                        for every country. From there I subsetted the data to focus on the 20 sub-Saharan countries that I had
                        exposure data on and added those rates onto my dataset. After I had a complete dataset I performed  a 
                        linear regression to gauge whether my hypothesis was correct. In the model I used the variation in policy
                        exposure compared against variation in the rates of maternal mortality while subsetting for abortion rates
                        in the targeted countries. "),
                      br(),
                      p("Write more text here"),
                      br(),
                      p("write about this graph here."),
                      plotlyOutput("WHOplot1"),
                      p("write about this graph here."),
                      plotlyOutput("WHOplot2"),
                      p("write about this graph here."),
                      plotlyOutput("WHOplot3")
                      
                    )
                    
           ),
           tabPanel("Foreign Aid Breakdown",
                    fluidPage(
                      titlePanel("The Global Impact of U.S. Foreign Aid Programs"),
                      plotlyOutput("aidplot1")
                    )
           )
)
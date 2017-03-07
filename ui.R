
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
           
           tabPanel("Viz 2",
                    fluidPage(
                      
                      titlePanel("Induced Abortions and Maternal Mortality in Sub-Saharan African Countries"),
                      
                      plotlyOutput("WHOplot1")
                      
                    )
                    
           ),
           tabPanel("Foreign Aid Breakdown",
                    fluidPage(
                      titlePanel("The Global Impact of U.S. Foreign Aid Programs"),
                      plotlyOutput("aidplot1")
                    )
           )
)
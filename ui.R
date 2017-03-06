
library(shiny)
library(dplyr)
library(ggplot2)

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
                    
           )
           

)
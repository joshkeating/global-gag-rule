
library(shiny)
library(dplyr)
library(markdown)
library(plotly)

data <- read.csv("./data/sub-saharan-exposure-and-maternal-mortality", stringsAsFactors = FALSE)

navbarPage("Global Gag Rule",
           
           tabPanel("Summary",
                    
                    fluidPage(
                      
                      includeMarkdown("summary.md")
                      
                    )
                    
           ),
           
           tabPanel("Viz 1",
           
                    fluidPage(
                      
                      titlePanel("Induced Abortions and Maternal Mortality in Sub-Saharan African Countries"),
                      
                      
                      plotlyOutput("plot")

                      
                    )
                    
           ),
           
           tabPanel("Viz 2"
                    
                    
           ),
           
           tabPanel("Viz 3"
                    
                    
           )
           

)
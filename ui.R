
library(shiny)
library(dplyr)
library(markdown)

navbarPage("Global Gag Rule",
           
           tabPanel("Summary",
                    
                    fluidPage(
                      
                      includeMarkdown("summary.md")
                      
                    )
                    
           ),
           
           tabPanel("Viz 1"
           
                    
           ),
           
           tabPanel("Viz 2"
                    
                    
           )
           

)
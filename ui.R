
library(shiny)
library(dplyr)
library(markdown)

data <- read.csv("./data/sub-saharan-exposure-and-maternal-mortality", stringsAsFactors = FALSE)

navbarPage("Global Gag Rule",
           
           tabPanel("Summary",
                    
                    fluidPage(
                      
                      includeMarkdown("summary.md")
                      
                    )
                    
           ),
           
           tabPanel("Viz 1",
           
                    fluidPage(
                      
                      titlePanel("Test"),
                      
                      
                      plotlyOutput("plot")
                      
                      
                      
                      # sidebarPanel(
                      #   
                      #   # creates select dropdown widget
                      #   selectInput("select", label = h3("Select Country"), 
                      #               choices = c(unique(as.character(data$Country))),
                      #               selected = "Benin"),
                      #   
                      #   helpText("Select something")
                      #   
                      # )
                      
                    )
                    
           ),
           
           tabPanel("Viz 2"
                    
                    
           ),
           
           tabPanel("Viz 3"
                    
                    
           )
           

)
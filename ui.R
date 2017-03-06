
library(shiny)
library(dplyr)
library(ggplot2)

navbarPage("Global Gag Rule",
           
           tabPanel("Summary", 
                    verbatimTextOutput("summary")
           ),
           
           tabPanel("Viz 1",
              sidebarLayout(
                sidebarPanel(
                  selectInput('y', 'Measure of Reproductive Health', names(UNyOpts1), names(UNyOpts1)[[1]])
                  ),
                mainPanel(
                  h3(textOutput("caption")),
                  plotlyOutput("UNplot")
                )
              )
                    
           ),
           
           tabPanel("Viz 2"
                    
                    
           )
           

)
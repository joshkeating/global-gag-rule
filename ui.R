
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
                      p("Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium,
                        totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta
                        sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia
                        consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem
                        ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut
                        labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem
                        ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure 
                        reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum 
                        fugiat quo voluptas nulla pariatur."),
                      plotlyOutput("WHOplot1"),
                      plotlyOutput("WHOplot2"),
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
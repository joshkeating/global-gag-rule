
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
                      p("Because of the complex relationship between abortion rates, this policy, and a host of other variables,
                        it becomes hard to make any blanket claims about the direct effect of the Global Gag Rule. With that stated,
                        in this analysis I have attempted to inspect some of the variables that may contribute to a change in rates 
                        for induced abortions and maternal mortality. In order to illuminate the effects of the Global Gag Rule the 
                        WHO rated each country in the study as having either low or high exposure to the policy. This rating was determined
                        by “the level of per capita financial assistance provided to the country for family planning and reproductive health
                        by the United States was above or below the median for the period 1995 to 2000”."),
                      br(),
                      p("In this first plot I explored the differences in the trends of induced abortion rates for the two main subsets
                        of my data; countries that were rated with a low exposure to the policy and countries rated with a high exposure.
                        Though we see an increase in abortion rates in countries that are considered highly exposed to the policy, the 
                        statistical significance is negligible. In the plot, the dashed vertical line marks the year the Global Gag Rule
                        was restored. The two curves were calculated from “observational data” using a locally weighted scatterplot 
                        smoothing (lowess) method."),
                      plotlyOutput("WHOplot1"),
                      br(),
                      p("This second plot gives a closer look at the way that abortion rates changed by country year over year.
                        Each country's data is plotted by the locally weighted scatterplot smoothing (lowess) method. By hovering
                        over the graph we can get a more granularized view of how induced abortion rates changed over time in this
                        subset of countries. Once again, the dashed vertical line marks the year the Global Gag Rule was restored."),
                      br(),
                      plotlyOutput("WHOplot2"),
                      br(),
                      p("This final plot represents a look into the decreasing rate of maternal mortality in the same subset of 
                        sub-Saharan countries that we’ve been looking at. Other than the sole outlier of Sierra Leone this plot of
                        data remains relatively uninteresting but is significant in its steady decline of maternal mortality calculated
                        by the locally weighted smoothing curve. As mentioned above, in the linear model that I used to calculate the
                        relationship between the effects of the GGR, maternal mortality and abortion rate I was unable to find a 
                        statistically significant relationship between these variables. This may be because there does not exist 
                        such a relationship but it is equally, if not more likely, that a relationship was not found because of the 
                        existence of variables that I was not able to control for. The trend of this graph highlights the reality that
                        without the data to control for influencing variables it remains difficult to make any substantial claims about
                        the global repercussions of the Mexico City Policy."),
                      br(),
                      plotlyOutput("WHOplot3")
                      
                    )
                    
           ),
           tabPanel("How NGOs are affected",
                    fluidPage(
                      titlePanel("NGO funding"),
                      plotlyOutput("aidplot1")
                    )
           )
)
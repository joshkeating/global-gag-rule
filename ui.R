
library(shiny)
library(dplyr)
library(plotly)
library(scales)

UNyOpts1 <- c("CP_Any_Method", "CP_Any_Modern_Method", "CP_Any_Traditional_Method", "UN_Unmet_Need_Total", "Demand_Satisfied_By_Modern_Methods")
names(UNyOpts1) <- c("Contraceptive Prevalence", "Contraceptive (Modern) Prevalence", "Contraceptive (Traditional) Prevalence", "% with Unmet Needs for Family Planning", "Proportion of Family Planning Demand Satisfied via Modern Methods")
countries <- c("Angola", "Benin", "Burundi", "Burkina Faso", "Cabo Verde", "Central African Republic", "Chad", "Comoros", "Djibouti", "Equatorial Guinea", "Eritrea", "Ethiopia", "Gabon", "Gambia", "Ghana", "Guinea-Bissau", "Guinea", "Kenya", "Liberia", "Madagascar", "Malawi", "Mali", "Mauritania", "Mozambique", "Niger", "Nigeria", "Rwanda", "Sao Tome and Principe","Senegal", "Sierra Leone", "the Seychelles", "Somalia", "South Sudan", "Sudan", "Swaziland", "Uganda", "United Republic of Tanzania", "Zambia", "Zimbabwe")

ngo_select <- c("John Snow International", "Jhpiego Corporation", "Pathfinder International", "EngenderHealth", "Marie Stopes International", "Management Sciences for Health", "FHI 360", "Population Services International", "Population Council", "IntraHealth International")

navbarPage("Global Gag Rule",
           
           tabPanel("Summary", 
                    fluidPage(
                      titlePanel("Overview And Impact Of The Mexico City Policy "),
                      h4("Also Known As - The Global Gag Rule"),
                      br(),
                      p("The issue of abortion in the United States is one that is fiercely debated and divides large segments
                        of the population. These divides are inherently partisan and therefore have led to legislation. In 1984
                        the Reagan administration signed into law the “Mexico City policy”, named for the city in which it was 
                        signed. The policy requires all non governmental organizations operating abroad to refrain from performing,
                        advising on or endorsing abortion as a method of family planning if they wish to continue to receive 
                        receive federal funding. The policy has had a tumultuous history, either being reinstated or rescinded 
                        depending on the party affiliation of the current president. Starting with Bill Clinton in 1993 the policy
                        was rescinded, then restored by George W. Bush in 2001, rescinded again by Barack Obama in 2009, and most 
                        recently restored by Donald J. Trump in 2017."),
                      br(),
                      p("At it’s heart, the ban is propelled by the desire to limit the use of U.S. taxpayer dollars to pay for 
                        abortion or abortion-related services. The consequences of this ban include the termination of abortion 
                        related services such as; education, family planning, counseling, and training. The all or nothing nature
                        of the ban would also cut off funds for non abortion related health services that would be offered at non
                        governmental health providers. This presents some serious public health concerns for areas of the world 
                        where these services are essential for maternal health and prenatal care. "),
                      br(),
                      p("We hypothesized that the institution of the ban could lead to a reduction in family planning services which
                        could then lead to an increase in induced abortions. By restricting the flow of funds into health clinics that
                        provide services related to abortion among others, the U.S. government restricts the amount of care that can be
                        provided to those utilizing those services. The aim of this project was to gather, analyze, and present data on
                        the past effects of the Global Gag Rule and create a resource that assists our audience in understanding the scope
                        of the policy, its observable impact on women’s health, and the pathways through which it influences public health
                        policy decisions outside of the United States.")
                    )
                    
           ),
           
           tabPanel("Measuring Reproductive Health",
                    fluidPage(
                      titlePanel("Measuring Reproductive Health in Sub-Saharan African Countries"),
                      p("While the World Contraceptive Use 2016 dataset included levels of contraceptive and family planning methods for an 
                        extensive number of countries across the world, we chose to analyze a certain subset of this data. After the raw excel
                        data was downloaded from the United Nations’ website, it required a substantial amount of cleaning because of the format
                        of the column headers. Once the columns were renamed, records for countries in sub-Saharan Africa were aggregated over
                        time using dplyr. Reproductive health metrics for married/in-union women of reproductive age were examined across the 
                        time periods where the Mexico City Policy was active and inactive in the United States. Our hypothesis was that during
                        periods where the policy was actively blocking funding, contraceptive prevalence would decrease, and unmet needs for 
                        family planning would increase. This would make sense because the policy blocks the entirety of funding for an organization
                        if it provides any abortion counseling, so many NGOs would not be able to operate."),
                      br(),
                      sidebarLayout(
                        sidebarPanel(
                          selectInput('y', 'Measure of Reproductive Health', names(UNyOpts1), names(UNyOpts1)[[1]])
                        ),
                        mainPanel(
                          plotlyOutput("UNplot1")
                        )
                      ),
                      br(),
                      p("An analysis of the United Nations’ data revealed several key insights. Throughout the period of 1984 to 2014, 
                        among all Sub-Saharan African countries, Zimbabwe and Cabo Verde had the highest prevalence of contraceptives, 
                        especially modern ones, which include sterilization, intra-uterine device (IUD), implant, injectables, pills, condoms,
                        barrier methods, LAM, emergency contraception and others. This indicates a strong presence of sexual education in the
                        population. Zimbabwe, which has a “low” exposure to the Mexico City Policy, as found in the WHO analysis, appears to
                        have a contraceptive prevalence level that is largely unaffected by the activity and inactivity of the policy, as
                        there is an upward increase for every year except 2011. In 2014, 66.9% of heterosexual couples in Zimbabwe used 
                        modern or traditional contraception. On the other hand, one year after, only 5.7% of the same grouping in Chad used
                        any form of modern or traditional contraception, which was extremely low. Mali, a country that is known to have a “high”
                        exposure to the policy, did not rise and fall in contraceptive prevalence as we anticipated in correlation with changes
                        in the legislation. Instead, it exhibited a slower but fairly steady upward trend, just as Zimbabwe did. The proportion
                        of family planning demand satisfied by modern methods grew every year, however, the percent with unmet needs for family
                        planning rose until around 2001 when it began to fall. As with these, and most of the other countries, there are not many
                        obvious trends during the time periods when the Mexico City Policy was in effect."),
                      br(),
                      p("Analysis of the United Nations’ data showed some interesting differences between sub-Saharan African countries with 
                        respect to contraceptive prevalence and needs for family planning. It is clear that countries like Zimbabwe have a 
                        more progressive use of contraceptives and family planning methods, and ones like Mali exhibit much less. However, 
                        our research sparks the question, why exactly is this the case? Economic and social changes in these countries must
                        be largely driving these changes, in conjunction with the Global Gag Rule. While our initial intent was to analyze 
                        the pure effects of the policy, it is clear that this is difficult as there are many complex factors at play. Each
                        country is often undergoing radical changes that affect women’s reproductive health and family life, only one of 
                        which is the mentioned Mexico City Policy.")
                      )
          ),
           
           tabPanel("Abortions and Maternal Mortality",
                    fluidPage(
                      
                      titlePanel("Induced Abortions and Maternal Mortality in Sub-Saharan African Countries"),
                      p("In approaching this analysis we needed to use some unconventional methods of data sourcing. For the data on
                        induced abortions and exposure to the “Global Gag Rule” (GGR) we scraped a .html table that the WHO made available
                        through the Stanford paper published on their website. Unfortunately for me, the hierarchy of the table did not
                        easily lend itself to reshaping in R so a considerable amount of work was done to convert it into a long form csv
                        file. We were curious about some of the potential public health effects that the ban could have had historically
                        on an area such as maternal mortality. The hypothesis that maternal mortality would be higher after the ban was 
                        instituted was based on our intuition. We found a dataset from the World Health Organization covering maternal 
                        mortality rates from 1990 to 2015 for every country. From there we broke the data into subsets to focus on the 
                        20 sub-Saharan countries that we had exposure data on and added those rates onto our dataset. After we had a 
                        complete dataset we performed a linear regression to gauge whether our hypothesis was correct. In the model we used
                        the variation in policy exposure compared against variation in the rates of maternal mortality while subsetting
                        for abortion rates in the targeted countries."),
                      br(),
                      p("Because of the complex relationship between abortion rates, this policy, and a host of other variables, it becomes
                        hard to make any blanket claims about the direct effect of the Global Gag Rule. With that stated, in this analysis 
                        we have attempted to inspect some of the variables that may contribute to a change in rates for induced abortions 
                        and maternal mortality. In order to illuminate the effects of the Global Gag Rule the WHO rated each country in the
                        study as having either low or high exposure to the policy. This rating was determined by “the level of per capita 
                        financial assistance provided to the country for family planning and reproductive health by the United States was 
                        above or below the median for the period 1995 to 2000”."),
                      br(),
                      p("In this first plot we explored the differences in the trends of induced abortion rates for the two main subsets of 
                        our data; countries that were rated with a low exposure to the policy and countries rated with a high exposure. Though
                        we see an increase in abortion rates in countries that are considered highly exposed to the policy, the statistical 
                        significance is negligible. In the plot, the dashed vertical line marks the year the Global Gag Rule was restored. 
                        The two curves were calculated from “observational data” using a locally weighted scatterplot smoothing (lowess) method."),
                      plotlyOutput("WHOplot1"),
                      br(),
                      p("This second plot gives a closer look at the way that abortion rates changed by country year over year. Each country's 
                        data is plotted by the locally weighted scatterplot smoothing (lowess) method. By hovering over the graph we can get a 
                        more granularized view of how induced abortion rates changed over time in this subset of countries. Once again, the dashed
                        vertical line marks the year the Global Gag Rule was restored."),
                      br(),
                      plotlyOutput("WHOplot2"),
                      br(),
                      p("This final plot represents a look into the decreasing rate of maternal mortality in the same subset of sub-Saharan countries
                        that we’ve been looking at. Other than the sole outlier of Sierra Leone this plot of data remains relatively uninteresting but
                        is significant in its steady decline of maternal mortality calculated by the locally weighted smoothing curve. As mentioned 
                        above, in the linear model that we used to calculate the relationship between the effects of the GGR, maternal mortality and
                        abortion rate we were unable to find a statistically significant relationship between these variables. This may be because there
                        does not exist such a relationship but it is equally, if not more likely, that a relationship was not found because of the 
                        existence of variables that we was not able to control for. The trend of this graph highlights the reality that without the 
                        data to control for influencing variables it remains difficult to make any substantial claims about the global repercussions 
                        of the Mexico City Policy in relation to maternal mortality."),
                      br(),
                      plotlyOutput("WHOplot3")
                      
                    )
                    
           ),
           tabPanel("Funding for NGOs",
                    fluidPage(
                      titlePanel("Funding Data for NGOs Working on Family Planning Activities"),
                      plotlyOutput("aidplot1"),
                      selectInput('ngo', 'Select an NGO', ngo_select, ngo_select[1]),
                      plotlyOutput("aidplot2")
                    )
                    # TODO (maybe):dynamically show a link for information on the selected NGO
           )
)
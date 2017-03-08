
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
                      br(),
                      p("The primary function of the Mexico City Policy (global gag rule) is to block US Federal Funding for non-governmental organizations (NGO) that provide
                        referrals, counselling, or advocacy for abortion as a method of family planning. Under this policy, NGOs that engage in any of these
                        projects are faced with choosing between eliminating programs that enable pro-choice family planning and potentially losing
                        significant amounts of funding from U.S. government agencies."),
                      p("Operating under past incarnations of the Mexico City Policy, foreign NGOs have had
                        to certify that they will not \"perform or actively promote abortion as a method of family planning\" as a condition for receiving U.S. assistance for family planning.
                        The current implementation of the Mexico City Policy as per the Presidential Memorandum of January 23, 2017 expands to place additional
                        restrictions on other U.S. health assistance programs including HIV, maternal and child health, and reproductive healthcare."),
                      p("Examined below are funding data obtained from the",
                        a(href="https://explorer.usaid.gov/aid-dashboard.html", "U.S. Agency for International Development"),
                        "which reports official records of all U.S. foreign aid obligations and disbursements."),
                      p("The first plot presents historical funding disbursements for NGO activities in the family planning sector."),
                      p("Along with yearly total U.S. disbursements to NGOs, this plot tracks
                        yearly totals for the 10 NGOs that received the most funding for family planning in fiscal years 2001-2016. A dashed vertical line denotes the year 2009, before which the
                        Mexico City Policy had been in effect under President George W. Bush and after which the policy was rescinded by President Barack Obama."),
                      br(),
                      plotlyOutput("aidplot1"),
                      br(),
                      br(),
                      p("As mentioned above, the recent reinstatement of the Mexico City Policy expands its jurisdiction to block policy-violating NGOs from U.S. Federal disbursements intended
                        for family planning as well as any other U.S. global health assistance."),
                      p("To illustrate the impact that this could have on funding for pivotal global health programs, the chart below presents
                        more information about each NGO observed in the first plot. Selecting an NGO from the dropdown displays the various other sectors in global health that each NGO addresses and receives U.S. foreign aid
                        funding for."),
                      p("Also included is additional information on each NGO, providing any available indication of their stance on the Mexico City Policy, links to related material, and ways to contribute donations to each NGO."),
                      br(),
                      selectInput('ngo', 'Select an NGO for more funding details', ngo_select, ngo_select[1]),
                      plotlyOutput("aidplot2"),
                      # what I would give for an ng-repeat right now
                      conditionalPanel(
                        condition = "input.ngo == 'John Snow International'",
                        h3("More from this NGO"),
                        br(),
                        tags$blockquote(
                          "\"It’s going to be harder for women particularly to have HIV testing and quick, immediate referrals for ARVs. Right now, we have a program in Zambia where women are referred for HIV testing and can get ARVs all in one single day. We are now potentially going to make this far more complicated for them, and there will be far more opportunities for people to drop out.\"",
                          br(),
                          a(href="http://jsi.com/JSIInternet/Newsroom/newsitem/display.cfm?a=1&id=2029", "- Andrew Fullem, director of the HIV and Infectious Diseases Center at John Snow, Inc")
                        ),
                        tags$blockquote("\"JSI stands with more than 140 partners in opposition to the U.S.-imposed Global Gag Rule, a policy that will leave millions of women and their families in the developing world without access to the critical health services that they need.\""),
                        tags$ul(
                          tags$li(a(href="https://www.refugeesinternational.org/advocacy-letters-1/global-gag-rule", "Endorses the Coalition Statement on Opposing the Gag Rule")))
                      ),
                      conditionalPanel(
                        condition = "input.ngo == 'EngenderHealth'",
                        h3("More from this NGO"),
                        br(),
                        tags$blockquote(
                          "\"It is a fundamental right for all women and girls to be allowed access to comprehensive sexual and reproductive health care. The Global Gag Rule effectively strips them of this right to make decisions in their private lives that will empower them to lift themselves out of poverty and enable them to live up to their full potential\"",
                          br(),
                          a(href="https://www.engenderhealth.org/media/2017/01-23-global-gag-rule-reinstated.php", "- Ulla Müller, President and CEO of EngenderHealth")
                        )
                      ),
                      conditionalPanel(
                        condition = "input.ngo == 'Pathfinder International'",
                        h3("More from this NGO"),
                        br(),
                        tags$blockquote(
                          "\"Imposing the global gag rule will force many organizations and clinicians to disregard their local laws and deny women rights that are legally theirs. Stopping organizations from speaking freely about abortion in their own countries is counter to the American commitment to free speech and promoting democracy.\"",
                          br(),
                          a(href="http://www.pathfinder.org/global-gag-rule-101/", "- Caroline Crosby, CEO of Pathfinder International")
                        )
                      ),
                      conditionalPanel(
                        condition = "input.ngo == 'Marie Stopes International'",
                        h3("More from this NGO"),
                        br(),
                        tags$blockquote(
                          "\"All the medical evidence, as well as everything we know from our daily interactions with women, is unequivocal: if you take safe abortion services out of the reproductive healthcare package, it exposes women to risk.\"",
                          br(),
                          a(href="https://mariestopes.org/news/2017/1/re-enactment-of-the-mexico-city-policy/", "- Marjorie Newman-Williams, Vice-President and Director of Marie Stopes International’s international operations")
                        )
                      ),
                      conditionalPanel(
                        condition = "input.ngo == 'IntraHealth International'",
                        h3("More from this NGO"),
                        br(),
                        tags$blockquote("\"Our mission is to improve the performance of health workers and strengthen the systems in which they work. Our vision is that everyone, everywhere has the health care they need to thrive.\""),
                        br(),
                        tags$ul(
                          tags$li(a(href="https://www.intrahealth.org/donate-now", "Accepting donations")),
                          tags$li(a(href="https://www.refugeesinternational.org/advocacy-letters-1/global-gag-rule", "Endorses the Coalition Statement on Opposing the Gag Rule"))
                        )
                      ),
                      conditionalPanel(
                        condition = "input.ngo == 'Management Sciences for Health'",
                        h3("More from this NGO"),
                        br(),
                        tags$blockquote(
                          "\"Reinstating the Global Gag Rule cripples health systems that use U.S. funds for comprehensive reproductive health care, and will shut down essential programs that increase access to services for HIV/AIDS and gender-based violence. The Global Gag Rule violates the right of all women to access comprehensive sexual and reproductive health care and to make informed choices about their health.\"",
                          br(),
                          a(href="https://www.msh.org/news-events/press-room/msh-statement-on-the-imposition-of-the-global-gag-rule", "Official statement on the imposition of the global gag rule")
                        ),
                        br(),
                        tags$ul(
                          tags$li(a(href="https://www.msh.org/donate", "Accepting donations")),
                          tags$li(a(href="https://www.refugeesinternational.org/advocacy-letters-1/global-gag-rule", "Endorses the Coalition Statement on Opposing the Gag Rule"))
                        )
                      ),
                      conditionalPanel(
                        condition = "input.ngo == 'Population Council'",
                        h3("More from this NGO"),
                        br(),
                        tags$blockquote(
                          "\"The Mexico City Policy will have a negative effect on the lives of millions of girls, women and families around the world and will impede countless global health projects and programs\"",
                          br(),
                          a(href="http://www.popcouncil.org/news/u.s.-governments-expanded-mexico-city-policy-threatens-womens-health", "Julia Bunting, Population Council president")
                        ),
                        br(),
                        tags$ul(
                          tags$li(a(href="http://www.popcouncil.org/donate", "Accepting donations")),
                          tags$li(a(href="https://www.refugeesinternational.org/advocacy-letters-1/global-gag-rule", "Endorses the Coalition Statement on Opposing the Gag Rule"))
                        )
                      ),
                      conditionalPanel(
                        condition = "input.ngo == 'Population Services International'",
                        h3("More from this NGO"),
                        br(),
                        tags$ul(
                          tags$li(a(href="http://www.psi.org/president-trump-threatens-womens-health-vip-conference-call/", "Public conference call denouncing the global gag rule")),
                          tags$li(a(href="https://give.psi.org/secure/year-of-healthy-life?ms=toplink", "Accepting donations"))
                        )
                      )
                    )
          )
)
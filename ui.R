
header <- dashboardHeader(
  title = "DrugsPlot - A Webtool for the visualization of data from EMCDDA",
  titleWidth = 650,
  #Facebook Sharing
  tags$li(class = "dropdown",
          tags$a(href = "http://www.facebook.com/sharer.php?u=https://databiomics.shinyapps.io/drugsplot/", 
                 target = "_blank", 
                 tags$img(height = "20px", 
                          src = "fb2.png")
          )
  ),
  # Linkedin link
  tags$li(class = "dropdown",
          tags$a(href = "http://www.linkedin.com/shareArticle?mini=true&url=hhttps://databiomics.shinyapps.io/drugsplot/", 
                 target = "_blank", 
                 tags$img(height = "20px", 
                          src = "linkedin.png")
          )
  ),
  
  # Github
  tags$li(class = "dropdown",
          tags$a(href = "https://github.com/frequena/DrugsPlot", 
                 target = "_blank", 
                 tags$img(height = "20px", 
                          src = "github.png")
          )
  ),
  # Twitter link
  tags$li(class = "dropdown",
          tags$a(href = "http://twitter.com/share?url=https://databiomics.shinyapps.io/drugsplot/  &text= Explore the consume of drugs in Europe with DrugsPlot!",
                 target = "_blank",
                 tags$img(height = "20px", 
                          src = "twitter.png")
          )
  )
)


sidebar <- dashboardSidebar(
  
  width = 250,
  sidebarMenu(id = 'tab',
              menuItem("Data Exploration", tabName = "data", icon = icon("flask")),
              menuItem("I'm looking for a job...Know me!",
                       icon = icon("at"), href = "http://www.databiomics.com/about")
  ),
  br(),
  br(),
  br(),
  br(),
  br(),
  br(),
  br(),
  br(),
  br(),
  br(),
  br(),
  hr(),
  
  # email sharing link
  menuItem("Feedback & suggestion", icon = icon("envelope-o"),
           href = "http://www.databiomics.com/about"))
body <-  dashboardBody(
  fluidRow(
    column(width = 2,
           box(title = "Type of drug", width = 200, solidHeader = TRUE, status = "primary",
               selectInput("select_drug", label = h4(""),
                           choices = list("Cannabis" = "can", "Cocaine" = "coc", 
                                          "Amphetamines" = "amp", "Ecstasy" = "ecs", 
                                          "LSD" = "lsd", "Any Illegal Drugs" = "any",
                                          "Alcohol" = "alc","Tobacco" = "tob"), 
                           selected = "can")),
           box(title = "Time of prevalence", width = 200, solidHeader = TRUE, status = "primary",
               selectInput("select_drug_cycle", label = h4(""),
                           choices = list("Lifetime prevalence" = "life", "Last year prevalence" = "year", 
                                          "Last month prevalence" = "month"), 
                           selected = "life")),
           box(title = "Interval of age", width = 200, solidHeader = TRUE, status = "primary",
               selectInput("select_drug_interval", label = h5(""),
                           choices = list("All adults (15-64)" = "all", "Young adults (15-34)" = "young", 
                                          "Aged 15-24" = "15", "Aged 25-34" = "25", 
                                          "Aged 35-44" = "35", "Aged 45-54" = "45",
                                          "Aged 55-64" = "55"), 
                           selected = "all")),
           box(title = "Genre", width = 200, solidHeader = TRUE, status = "primary",
               selectInput("select_drug_genre", label = h5(""),
                           choices = list("Female" = "fe", "Male" = "ma", 
                                          "Total" = "to"), 
                           selected = "fe")),
           box(title = "Download Information used", width = 200, solidHeader = TRUE, status = "primary",
               downloadButton('downloadData', 'Download data used (.csv)'),
               tags$hr(),
               downloadButton('downloadData2', 'Download report with graphics')
           ),
           box(title = "Developed by", width = 200, solidHeader = TRUE, status = "primary",
               tags$a(href="www.databiomics.com", "Francisco Requena")
               
           ),
           box(title = "Data source", width = 200, solidHeader = TRUE, status = "primary",
               img(src = "logo.jpg", height = 100, width = 230)
           )),
    
    
    
    column(width = 5, solidHeader = TRUE,
           box(width = NULL, solidHeader = TRUE,
               tabsetPanel(type = "tabs", 
                           tabPanel("European map",  plotOutput("map")))
           )),
    column(width = 5, solidHeader = TRUE,
           box(width = NULL, solidHeader = TRUE,
               tabsetPanel(type = "tabs", 
                           tabPanel("Interactive boxplot graphic",  plotlyOutput("map_boxplot")))
           )),
    column(width = 10, solidHeader = TRUE,
           box(width = NULL, solidHeader = TRUE,
               tabsetPanel(type = "tabs", 
                           tabPanel("Bar graphic",  plotOutput("map_numeric")),
                           tabPanel("Sample size",  plotOutput("sample")))
           ))
  )
)

dashboardPage(
  header,
  sidebar,
  body
)

library(shiny)

shinyUI(fluidPage(

  titlePanel("Car per gallon mileage by trasmission type"),

  sidebarLayout(
    sidebarPanel(
      p("With this application you can exlore relationship between 
         car mileage and transmission type, using various cofounder variables"),
      selectInput("variable", "Select cofounder variable:",
                  list("Number of cylinders" = "cyl", 
                       "Number of forward gears" = "gear",
                       "Weight (lb/1000)" = "wt",
                       "Gross horsepower" = "hp",
                       "Displacement (cu.in.)" = "disp",
                       "1/4 mile time" = "qsec",
                       "Number of carburetors" = "carb",
                       "Rear axle ratio" = "drat",
                       "V/S" = "vs")),
      p("На вкладке Scatterplot отображаются"),
      p("Boxplot"),
      p("Regression coefficients"),
      p("QQ plot"),
      p("Residuals")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Scatterplot", plotOutput("pairPlot", height = 500)), 
        tabPanel("Boxplot", plotOutput("boxPlot", height = 500)),
        tabPanel("Regression coefficients",
                 textOutput("formula0"),
                 tableOutput("coeff0")
        ),
        tabPanel("QQ plot", plotOutput("qqPlot", height = 500)),
        tabPanel("Residuals" ,plotOutput("resPlot", height = 500))
      )
    )
  )
))

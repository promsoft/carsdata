library(shiny)

shinyUI(fluidPage(

  titlePanel("Car per gallon milleage by trasmission type"),

  sidebarLayout(
    sidebarPanel(
      selectInput("variable", "Cofounder variable:",
                  list("Number of cylinders" = "cyl", 
                       "Number of forward gears" = "gear",
                       "Weight (lb/1000)" = "wt",
                       "Gross horsepower" = "hp",
                       "Displacement (cu.in.)" = "disp",
                       "1/4 mile time" = "qsec",
                       "Number of carburetors" = "carb",
                       "Rear axle ratio" = "drat",
                       "V/S" = "vs"))
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Scatterplot and marginal regression", plotOutput("pairPlot", height = 500)), 
        tabPanel("Boxplot", plotOutput("boxPlot", height = 500)),
        tabPanel("Regression coefficients",
                 textOutput("formula0"),
                 tableOutput("coeff0")
        ),
        tabPanel("QQ plot", plotOutput("qqPlot", height = 500)),
        tabPanel("res plot", plotOutput("resPlot", height = 500))
      )
    )
  )
))

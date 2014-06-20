library(shiny)

shinyUI(fluidPage(

  titlePanel("Miles/(US) gallon by Transmission type"),

  sidebarLayout(
    sidebarPanel(
      selectInput("variable", "Variable:",
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
        tabPanel("Scatterplot", plotOutput("pairPlot", height = 500)), 
        tabPanel("Boxplot", plotOutput("boxPlot", height = 500)),
        tabPanel("Regression coefficients", tableOutput("coeff0"), tableOutput("coeff1"), tableOutput("coeff2"))
      )
    )
  )
))


# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Miles/(US) gallon by Transmission type"),

  # Sidebar with a slider input for number of bins
  
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
                       "V/S" = "vs")),
      tableOutput("coefficients")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel("Mpg ~ variable", plotOutput("pairPlot", height = 300)), 
        tabPanel("Boxplot", plotOutput("boxPlot", height = 300))
        
      )
    )
  )
))

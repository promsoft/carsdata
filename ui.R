library(shiny)

shinyUI(fluidPage(

  titlePanel("Car per gallon mileage by trasmission type"),

  sidebarLayout(
    sidebarPanel(
      p("You can exlore relationship between 
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
      h5("Scatterplot"),
      p("На вкладке Scatterplot отображаются"),
      h5("Boxplot"),
      p("Boxplot for cofounder variable, splitted by transmission type"),
      h5("Regression coefficients"),
      p("R Squared and regression coefficients for regression model"),
      h5("QQ plot"),
      p("Theoretical Quantile-Quantile Plot"),
      h5("Residuals"),
      p("Residuals plot (residuals vs fited values)")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Scatterplot", plotOutput("pairPlot", height = 500)), 
        tabPanel("Boxplot", plotOutput("boxPlot", height = 500)),
        tabPanel("Regression coefficients",
                 textOutput("formula"),
                 textOutput("formula0"),
                 tableOutput("coeff0")
        ),
        tabPanel("QQ plot", plotOutput("qqPlot", height = 500)),
        tabPanel("Residuals" ,plotOutput("resPlot", height = 500))
      )
    )
  )
))

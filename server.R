library(shiny)
data(mtcars)
color0 <- 'turquoise4'
color1 <- 'darkorange'
color2 <- 'gray'
set0 <- mtcars[mtcars$am==0,]
set1 <- mtcars[mtcars$am==1,]

mark.twain <- function(x) {
  parmar <- par('mar')
  par(mar = c(4, 4, 0, 2))
  plot(mtcars[[x]]
       , mtcars$mpg
       , col=ifelse(mtcars$am==0, color0, color1)
       , xlab=x
       , ylab='mpg')
  
  fit0 <- lm(set0$mpg~set0[[x]])
  abline(fit0, col=color0, lw=2)
  fit1 <- lm(set1$mpg~set1[[x]])
  abline(fit1, col=color1, lw=2)
  fit2 <- lm(mtcars$mpg~mtcars[[x]])
  abline(fit2, col=color2, lty=3, lw=2)
  legend("topright", pch = 1
         , col = c(color0, color1)
         , legend = c("manual", "automatic"))
  f.diff <- summary(fit1)$coeff - summary(fit0)$coeff 
  par(mar=parmar)
}

do.box <- function(x) {
  parmar <- par('mar')
  par(mar = c(4, 4, 0, 2))
  boxplot(formula(paste0(x, '~am'))
          , data = mtcars
          , col = c('turquoise4', 'darkorange')
          , ylab = x
          , names = c('manual', 'automatic'))
  par(mar=parmar)
}

shinyServer(function(input, output) {
  output$pairPlot <- renderPlot({
    variable <- input$variable
    mark.twain(variable)
  })
  
  output$boxPlot <- renderPlot({
    variable <- input$variable
    do.box(variable)
  })
  
  output$coeff0 <- renderTable({
    fit2 <- lm(formula(paste0("mpg~am+", input$variable)), set0)
    data.frame(summary(fit2)$coeff)
  })
  
  output$coeff1 <- renderTable({
    fit2 <- lm(formula(paste0("mpg~am+", input$variable)), set1)
    data.frame(summary(fit2)$coeff)
  })
  
  output$coeff2 <- renderTable({
    fit2 <- lm(formula(paste0("mpg~am+", input$variable)), mtcars)
    data.frame(summary(fit2)$coeff)
  })

  output$formula0 <- renderText({
    paste0("mpg~am+", input$variable)
  })
  
  
})

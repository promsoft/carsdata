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
  if(x == 0) {
    fit2 <- lm(mpg~am, mtcars)
    abline(fit2, col=color2, lty=3, lw=2)    
    
  } else {
    formula0 <- paste0('mpg~', x)
    fit0 <- lm(formula(formula0), set0)
    abline(fit0, col=color0, lw=2)
    
    fit1 <- lm(formula(formula0), set1)
    abline(fit1, col=color1, lw=2)
    
    fit2 <- lm(formula(formula0), mtcars)
    abline(fit2, col=color2, lty=3, lw=2)    
  }
  
  legend("topright", pch = c(1, 1, 45, 45, 45)
         , col = c(color0, color1, color0, color1, color2)
         , legend = c("manual", "automatic", "marg. manual", "marg. auto", paste0("mpg~", x))
         )
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
    cofounder <- input$variable
    fit2 <- lm(formula(paste0("mpg~am+", cofounder, "+am:", cofounder)), mtcars)
    data.frame(summary(fit2)$coeff)
  })

  output$formula0 <- renderText({
    cofounder <- input$variable
    frm <- paste0("mpg~am+", cofounder, "+am:", cofounder)
    fit <- lm(formula(frm), mtcars)
    paste0("R.squared=", summary(fit)$r.squared)
  })
  
  output$qqPlot <- renderPlot({
    parmar <- par('mar')
    par(mar = c(4, 4, 0, 2))
    cofounder <- input$variable
    frm <- paste0("mpg~am+", cofounder, "+am:", cofounder)
    fit <- lm(formula(frm), mtcars)
    res <- residuals(fit)
    qqnorm(res, main='')
    qqline(res, main='')
    par(mar=parmar)
  })

  output$resPlot <- renderPlot({
    parmar <- par('mar')
    par(mar = c(4, 4, 4, 2))
    cofounder <- input$variable
    frm <- paste0("mpg~am+", cofounder, "+am:", cofounder)
    fit <- lm(formula(frm), mtcars)
    res <- residuals(fit)
    fits <- fitted(fit)
    plot(res ~ fits, main='Residuals plot')
    abline(h = 0)
    par(mar=parmar)
  })
  
})

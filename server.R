library(shiny)
library(psych)

shinyServer(function(input, output, session) {
  #input$button
  
  staff <- reactive({
    input$button
    height <- as.numeric(input$height)
    sex <- input$sex
    rel <- as.numeric(input$test)
    
    male_M <- 180
    male_SD <- 7
    female_M <- 167
    female_SD <- 6.1
    
    male_SE <- male_SD * sqrt(1 - rel)
    female_SE <- female_SD * sqrt(1 - rel)
    
    rnormA <- repeatable(rnorm)
    
    if (sex == "man") {
      result <- rnormA(1, height, male_SE)
      IQ <- 100 + (result - male_M) / male_SD * 15
    } else {
      result <- rnormA(1, height, female_SE)
      IQ <- 100 + (result - female_M)/ (female_SD) * 15
    }
    IQ <- c(round(IQ, 0), result)
  })
  
  output$IQ <- renderText({
    input$button
    staff()[1]
  })
  output$height <- renderText({
    input$button
    round(staff()[2], 0)
  })
  output$perc <- renderText({
    input$button
    round(pnorm(staff()[1], 100, 15)*100, 0)
  })
  output$gauss <- renderPlot({
    x <- seq(40, 160, by=.01)
    y <- dnorm(x, 100, 15)
    if (staff()[1] < 50) {
      by.par <- -.01
    } else {
      by.par <- .01
    }
    x2 <- seq(50, staff()[1], by=by.par
    
    plot(x, y, type="l", lwd=3, col="darkblue", main="Gauss curve", xlab="intelligence scale (IQ)", ylab="") ##, yaxt="y"
    abline(v=staff()[1], lwd=3, col="red")
    polygon(c(x[x <= staff()[1]], staff()[1]), c(y[x <= staff()[1]], 0), col="lightblue")
    text(staff()[1]+1, y=.005, labels = paste("Your IQ =", staff()[1]), pos=4, srt=90)
  })
  
  
})

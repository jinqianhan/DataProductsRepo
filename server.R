library(shiny)
library(datasets)

# Because the mpgData does not rely on user inputs the data is processed before the server is loaded
# For the purpose of making the graph x axis look nicer, the transmission variable was converted into factor variables
mpgData <- subset(mtcars, select=c("am", "mpg"))
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))

shinyServer(function(input, output) {
  
  # If user opted to see an example, 2 datasets were prepared as examples
          datasetInput <- reactive({
                switch(input$example,
                       "linreg" = cars,
                       "ttest" = mpgData)
          })
          
          output$egplot <- renderPlot({
                  if (input$example == "no, I want to input my own values"){
                  }
                  else {
                          plot(datasetInput())
                  }
          })
                
          output$test <- renderPrint({
                  if (input$example == "linreg") {"Pearson's correlation with simple linear regression"}
                  else if(input$example == "ttest") {"Student's t test"}
                  else {
                          if (input$dependent == "categorical" && input$independent == "categorical" && input$paired == "unpaired" && input$numgroups == 2){"Pearson's chi squared test"}
                          else if (input$dependent == "categorical" && input$independent == "categorical" && input$paired == "unpaired" && input$numgroups == 1){"Z-test for one sample proportion"}
                          else if (input$dependent == "categorical" && input$independent == "categorical" && input$paired == "unpaired" && input$numgroups > 2){"rxc Contingency chi squared test"}
                          else if (input$dependent == "categorical" && input$independent == "numeric"){"logistic regression"}
                          else if (input$dependent == "categorical" && input$independent == "categorical" && input$paired == "paired"&& input$numgroups <= 2){"McNemar's chi squared test"}
                          else if (input$dependent == "categorical" && input$independent == "categorical" && input$paired == "paired" && input$numgroups > 2){"Mantael-Hanszel chi squared test"}
                          else if (input$dependent == "numeric" && input$independent == "categorical" && input$paired == "unpaired" && input$normal == "yes" && input$numgroups == 2){"Student's t test"}
                          else if (input$dependent == "numeric" && input$independent == "categorical" && input$paired == "unpaired" && input$normal == "yes" && input$numgroups == 1){"Z-test vs a population mean"}
                          else if (input$dependent == "numeric" && input$independent == "categorical" && input$paired == "unpaired" && input$normal == "yes" && input$numgroups > 2){"One-way ANOVA"}
                          else if (input$dependent == "numeric" && input$independent == "categorical" && input$paired == "paired" && input$normal == "yes" && input$numgroups > 2){"Repeated Measures ANOVA"}
                          else if (input$dependent == "numeric" && input$independent == "categorical" && input$paired == "paired" && input$normal == "yes" && input$numgroups <= 2){"Paired t test"}
                          else if (input$dependent == "numeric" && input$independent == "categorical" && input$paired == "unpaired" && input$normal == "no" && input$numgroups == 2){"Wilcoxon Rank Sum Test"}
                          else if (input$dependent == "numeric" && input$independent == "categorical" && input$paired == "unpaired" && input$normal == "no" && input$numgroups == 1){"Z-test"}
                          else if (input$dependent == "numeric" && input$independent == "categorical" && input$paired == "unpaired" && input$normal == "no" && input$numgroups > 2){"Kruskal-Wallis test"}
                          else if (input$dependent == "numeric" && input$independent == "categorical" && input$paired == "paired" && input$normal == "no" && input$numgroups <= 2){"Wilcoxon Signed Rank Test"}
                          else if (input$dependent == "numeric" && input$independent == "categorical" && input$paired == "paired" && input$normal == "no" && input$numgroups > 2){"Friedman, Kendall and Smith Test"}
                          else if (input$dependent == "numeric" && input$independent == "numeric" && input$numgroups > 1){"Multiple Linear regression"}
                          else if (input$dependent == "numeric" && input$independent == "numeric" && input$normal == "yes"){"Pearson's correlation with simple linear regression"}
                          else if (input$dependent == "numeric" && input$independent == "numeric" && input$normal == "no"){"Spearson's correlation with simple linear regression"}
                          else {"I'm not sure"}
                  }
          })
          
          output$pval <- renderPrint({
                  if (input$example == "ttest") {paste("p value =",signif(t.test(mpgData$mpg~mpgData$am, var.equal = TRUE)$p.value, 3), ", t statistic =", signif(t.test(mpgData$mpg~mpgData$am, var.equal = TRUE)$statistic,3))}
                  else if (input$example == "linreg") {paste("Pearson's r =",signif(cor(cars$speed, cars$dist),3), ", lm intercept:", signif(lm(cars)$coefficients[[1]],3), ", lm slope:", signif(lm(cars)$coefficients[[2]],3))}
          })
          
          output$inputVal1 <- renderPrint({
                  if (input$example == "linreg") {"numeric"}
                  else if (input$example == "ttest") {"numeric"}
                  else{
                  input$dependent
                  }
          })
          output$inputVal2 <- renderPrint({
                  if (input$example == "linreg") {"numeric"}
                  else if  (input$example == "ttest") {"categorical"}
                  else{
                  input$independent
                  }
          })
          output$inputVal3 <- renderPrint({
                  if (input$example == "linreg") {"no"}
                  else if  (input$example == "ttest") {"no"}
                  else{
                          if (input$paired == "unpaired") {"no"}
                          else {"yes"}
                  }
          })
          output$inputVal4 <- renderPrint({
                  if (input$example == "linreg") {"yes"}
                  else if  (input$example == "ttest") {"yes"}
                  else{
                  input$normal
                  }
          })
          output$inputVal5 <- renderPrint({
                  if (input$example == "linreg") {1}
                  else if  (input$example == "ttest") {2}
                  else{
                  input$numgroups
                  }
          })
}) 
library(shiny)
library(datasets)

# Define UI for dataset viewer application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Which Statistical Test Should I use?"),

  sidebarPanel(
    radioButtons("example", "Show Example", 
                choices = c("no, I want to input my own values", "linreg", "ttest")),
    
    selectInput("dependent", "What data type is your dependent variable?:", 
                choices = c("categorical", "numeric")),
    
    selectInput("independent", "What data type is your independent variable?:", 
                choices = c("categorical", "numeric")),
    
    selectInput("paired", "is your data paired/matched?:", 
                choices = c("unpaired", "paired")),
    
    selectInput("normal", "is your data normally distributed?:", 
                choices = c("yes", "no")),
    
    numericInput('numgroups', 'How many sample groups do you have?', 2, min = 1, max = 100, step = 1),
    
    submitButton('Submit')
  ),
  
  mainPanel(
    h3("Your data has the following parameters: "), 
    h4("dependent var"),
    verbatimTextOutput("inputVal1"), 
    h4("independent var"),
    verbatimTextOutput("inputVal2"), 
    h4("paired or matched?"),
    verbatimTextOutput("inputVal3"), 
    h4("normal?"),
    verbatimTextOutput("inputVal4"), 
    h4("number of groups:"),
    verbatimTextOutput("inputVal5"), 
    h4("therefore, you should use:"),
    h3(textOutput("test")),
    
    plotOutput("egplot"),
    verbatimTextOutput("pval") 
  )
)) 
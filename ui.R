library(shiny)

shinyUI(pageWithSidebar(
  # Application title
  headerPanel("Let's measure your height psychologicaly!"),
  sidebarPanel(
    radioButtons("sex", label = "You are:",
                 choices = list(man="man", woman="woman")),
    textInput("height", label = "Your true height is:", value=180, width='150px'),
    selectInput("test", label = "How good is your IQ test?", 
                choices = list('Bad one (r=.60)' = .60,
                               'Acceptable (r=.70)' = .70,
                               'Enough good (r=.80)' = .80,
                               'Good one (r=.90)' = .90,
                               'The best one (r=.95)' = .90
                               )),
    actionButton(inputId="button", label="Let's measure!"),
    HTML("<br><hr><p><i>This simple tool was developed as a joke to illustrate, why it is not a good idea to trust your exact IQ value 
reported by a psychological tests.<br> 
Author ot this application is a psychologist engaged in developing psychological tests.</i></p>
<p>&copy; 2017 Hynek Cígler<br>
Department of psychology, Faculty of Social Studies<br>
Masaryk University, Brno, Czech Republic<br>
<a href='XX'>Source code on Git-Hub</a></p>")
                ),
  mainPanel(h3("Your height is (just now)", textOutput("height", inline=T), "cm, which means", textOutput("IQ", inline=T), 
               "IQ", "and percetile", textOutput("perc", inline=T), "."),
            plotOutput("gauss"),
            h3("Do you want to know what will be your IQ just tomorrow?"),
            h3("Click on the 'Let's measure!' button on the left side!")
    
  ))
  
)
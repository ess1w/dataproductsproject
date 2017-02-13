#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
library(ISLR)
library(ggplot2)
library(lattice)
library(caret)
library(shiny)

# Define server logic required to calculate and draw the prediction
shinyServer(function(input, output) {
  
  # Load wage data 
  data(Wage)
  Wage <- subset(Wage,select=-c(logwage))
  
  # Create a building data set and validation set
  inBuild <- createDataPartition(y=Wage$wage,
                                 p=0.7, list=FALSE)

  validation <- Wage[-inBuild,]; buildData <- Wage[inBuild,]
  
  inTrain <- createDataPartition(y=buildData$wage,
                                 p=0.7, list=FALSE)
  training <- buildData[inTrain,]; testing <- buildData[-inTrain,]
  
  # Create the model
  mod1 <- reactive({
    if (input$addRace) {
      train(wage ~ age + maritl + race + education,method="glm",data=training)
    } else {
      train(wage ~ age + maritl + education,method="glm",data=training)
    }})

  model1pred <- reactive({
      ageInput <- input$sliderAge
      maristatInput <- input$maristat
      educInput <- input$educ
      if (input$addRace) {
        raceInput <- input$race
        predict(mod1(),newdata = data.frame(age = ageInput, maritl = maristatInput, race = raceInput, education = educInput))
      } else {
        predict(mod1(),newdata = data.frame(age = ageInput, maritl = maristatInput, education = educInput))
    }})
      
  # Add documentation text
  docText1 <- "This application is used to predict a person's wage based on their age, educational level and marital status. Race can optionally be used as a predictor."
  docText2 <- "To start, click on the Application tab. Use the slider to change the age, and select marital status an education by checking the appropriate options."
  docText3 <- "The predicted wage will change in the chart plot (represented by a red dot) as well as the text below the chart as you change your selection."
  docText4 <- "To include race as a predictor, check the Include Race checkbox. You can then select the race to see the effect it has on the predicted wage."
  output$docs <- renderUI(HTML('<p>', paste(docText1, '</p>', '<p>', docText2, '</p>', '<p>', docText3, '</p>', '<p>', docText4, '<br /')))

  output$plot1 <- renderPlot({
    ageInput <- input$sliderAge
    # generate bins based on input$bins from ui.R

    # Draw the plot
    plot(Wage$age, Wage$wage, xlab = "Age", ylab = "Wage", bty = "n", 
         pch = 16, xlim = c(18, 70), ylim = c(10, 350))
    
    abline(mod1(), col = "red", lwd = 2)
    
    legend(18,380,c("GLM Prediction"), pch = 16, col = "red",
           bty = "n", cex = 1.2)
    points(ageInput, model1pred(), col = "red", pch = 16, cex = 2)
  })
  
  output$pred1 <- renderText({
    model1pred()
  })
})

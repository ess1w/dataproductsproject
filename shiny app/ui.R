#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict Wage from Age, Marital Status, Education and Race"),
  
  # Sidebar with a slider input, radio buttons and a checkbox 
  sidebarLayout(
    sidebarPanel(
       sliderInput("sliderAge",
                   "Select the age of the Person:",
                   min = 18,
                   max = 70,
                   value = 25),
       radioButtons("maristat", "Marital Status:",
                    c("Never married" = "1. Never Married",
                      "Married" = "2. Married",
                      "Widowed" = "3. Widowed",
                      "Divorced" = "4. Divorced",
                      "Separated" = "5. Separated")),
         radioButtons("educ", "Education level:",
                      c("< HS Grad" = "1. < HS Grad",
                        "HS Grad" = "2. HS Grad",
                        "Some College" = "3. Some College",
                        "College Grad" = "4. College Grad",
                        "Advanced Degree" = "5. Advanced Degree")),
       checkboxInput("addRace", "Include Race", value = FALSE),
       conditionalPanel(
         condition = "input.addRace == true",
         radioButtons("race", "Race:",
                      c("White" = "1. White",
                        "Black" = "2. Black",
                        "Asian" = "3. Asian",
                        "Other" = "4. Other"))
       )
    ),
    
    # Show a plot of the prediction
    mainPanel(
      tabsetPanel(type = "tabs",
          tabPanel("Documentation", br(), htmlOutput("docs")),
          tabPanel("Application", br(), 
                   plotOutput("plot1"),
                   h3("Predicted Wage from GLM Model:"), textOutput("pred1")))
      
    )
  )
))

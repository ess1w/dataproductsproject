---
title       : Predict Wage by Age, Marital Status, Education and Race
subtitle    : Using Generalised Linear Modeling
author      : Daniel Chaytor
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Introduction

This presentation introduces the PredictWage application. Using the Wage data in the ISLR package in R, it demonstrates how to predict the wages of individuals based on their age, sex, marital status, level of education, and, optionally, their race.

The application uses a popular prediction model, generalised linear modeling. The user can

1. Predict a person's wages based on age, marital sex and education
2. View the effect of adding race as an additional predictor
3. View the predicted result both graphically and as text output 

--- .class #id 

## Wage Data

A small sample of the data is shown below.


```
       age     sex           maritl     race       education
231655  18 1. Male 1. Never Married 1. White    1. < HS Grad
86582   24 1. Male 1. Never Married 1. White 4. College Grad
161300  45 1. Male       2. Married 1. White 3. Some College
155159  43 1. Male       2. Married 3. Asian 4. College Grad
11443   50 1. Male      4. Divorced 1. White      2. HS Grad
376662  54 1. Male       2. Married 1. White 4. College Grad
```

Before we make predictions, we create training and testing sets from the data. The training set has 1,424 observations and 11 variables.


```
[1] 1474   11
```

--- .class #id 

## Processing and Predictions

Creating our model on the training set, a plot of wage versus age is shown below:


```r
mod1 <- train(wage ~ age + maritl + race + education,method="glm",data=training)
pred1 <- predict(mod1,testing) 
```

![plot of chunk unnamed-chunk-4](assets/fig/unnamed-chunk-4-1.png)

--- .class #id 

## The Completed Application

* The application is hosted on RStudio's ShinyApp server at [this URL](https://twinhype.shinyapps.io/predictwage/).

* Provides a simple user interface allowing you to select the person's age using a slider, with radio buttons for the other predictors. 

* To include race as a predictor, select the Include Race checkbox.








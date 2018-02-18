#Loading data from CSV file.
toyotaData.df <- read.csv("D:\\edu\\Data Mining\\lectures\\R files\\ToyotaCorolla.csv",header = TRUE)

#Viewing the dimensions od the data set
dim(toyotaData.df)

#selecting first thousand rows of the data.
toyotaData.df <- toyotaData.df[1:1000,]

#reading the labels of data
names(toyotaData.df)

#viweing the first six rows of data.
head(toyotaData.df)

#selecting variables for regression
selected.var <- c(3,4,7,8,9,10,12,13,14,17,18)

#Setting seed to partition the data
set.seed(9)

#Partitionong the data
train.index <- sample(row.names(toyotaData.df), 0.6*dim(toyotaData.df)[1])
train.df <- toyotaData.df[train.index, selected.var]
valid.index <- setdiff(row.names(toyotaData.df), train.index)
valid.df <- toyotaData.df[valid.index, selected.var]
View(train.df)

#to make sure that numbers are not displayed in scientific notation
options(scipen = 999)

#Finding the regression coefficients 
toyotaData.lm <- lm(Price ~ ., data = train.df)

#using the library(forecast) to predict the prices of valid data
#install.packages("forecast")
library(forecast)
toyotaData.lm.pred <- predict(toyotaData.lm, valid.df)

#calculating the difference between the orginal prices and 
difference <- valid.df$Price[1:20] - toyotaData.lm.pred[1:20]

data.frame("Predicted" = toyotaData.lm.pred[1:20], "Actual" = valid.df$Price[1:20],
           difference)

#using accuracy() to compute common accuracy measures like mean error, RMSE etc.
accuracy(toyotaData.lm.pred, valid.df$Price)

#the mean error is 18.07 and root mean square error is 1331.8

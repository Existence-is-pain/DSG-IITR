#### Rushith Kalakonda, 14311016.
### Training data analysis

mushroom.df <- read.csv("mushroom_train.csv")

#Variable 'veil.type' can be eliminated as it has only one category, 'p' throughout.
mushroom.df$veil.type <- NULL

#Identifying the missing values
mushroom.df[mushroom.df == "?"] <- NA
library(mice)
md.pattern(mushroom.df)

#Converting continuous variables 'weight' and 'radius' to factor variables.
mushroom.df$weight <- cut(mushroom.df$weight, c(0,10,20,30,40,50,60,70,80,90,102))
mushroom.df$radius <- cut(mushroom.df$radius, c(0,100,200,300,400,500,600,700,800,900,2300,3500))

#Predicting the missing values using kNN-Imputation method
library(VIM)
corrected.df <- kNN(mushroom.df, variable = c("stalk.root","weight"), k = 32, imp_var = FALSE)
corrected.df$stalk.root <- factor(corrected.df$stalk.root)

##1-R classifier
library(OneR)
model1 <- OneR(class ~ ., data = corrected.df)
model1
summary(model1)
#Plotting 'class' against 'odor'
library(ggplot2)
qplot(factor(odor),data = corrected.df,geom = "bar",fill = factor(class))
#This plot shows how important is 'odor' as a classifier

##Recursive Partitioning
library(rpart)
library(rpart.plot)
model2 <- rpart(class ~., data = corrected.df)
rpart.plot(model2)
summary(model2)

##RIPPER algorithm
library(RWeka)
model3_trial <- JRip(class ~., data = corrected.df)
model3_trial

#Avoiding overfitting of RIPPER algorithm using results from 'model3_trial'
model3 <- JRip(class ~ odor + gill.color + spore.print.color, data = corrected.df)
model3
summary(model3)


###Test Data and prediction

#Proceeding similarly for the test data
test.df <- read.csv("mushroom_test.csv")
newtest.df <- test.df

newtest.df$veil.type <- NULL

newtest.df[newtest.df == "?"] <- NA

newtest.df$weight <- cut(test.df$weight, c(0,10,20,30,40,50,60,70,80,90,102))
newtest.df$radius <- cut(test.df$radius, c(0,100,200,300,400,500,600,700,800,900,2300,3500))

newtest.df <- kNN(newtest.df, variable = "stalk.root", k = 25, imp_var = FALSE)
newtest.df$stalk.root <- factor(newtest.df$stalk.root)

##Prediction using model1
prediction1 <- predict(model1, newdata = newtest.df)
prediction1_table <- cbind(prediction1, test.df)

##Prediction using model2
prediction2 <- round(predict(model2, newdata = newtest.df))
prediction2_table <- cbind(prediction2, test.df)

##Prediction using model3
prediction3 <- predict(model3, newdata = newtest.df)
prediction3_table <- cbind(prediction3, test.df)



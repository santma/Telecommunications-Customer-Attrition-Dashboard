##Data Preprocessing 

#Importing dataset
dataset = read.csv('data/Telco-Customer-Churn.csv')

# Setting "No" values 
library(plyr)
dataset[dataset == 'No internet service'] <- 'No'
dataset[dataset == 'No phone service'] <- 'No'
dataset$SeniorCitizen[dataset$SeniorCitizen == 1] <- 'is Senior Citizen'
dataset$SeniorCitizen[dataset$SeniorCitizen == 0] <- 'is not Senior Citizen'
dataset$Partner <- revalue(dataset$Partner, c('Yes' = 'has Partner', 'No' = 'Single'))
dataset$Dependents <- revalue(dataset$Dependents, c('Yes' = 'has Dependents', 'No' = 'no Dependents'))
dataset$InternetService <- revalue(dataset$InternetService, c('No' = 'No Internet'))
dataset$PhoneServ <- paste(dataset$PhoneService, dataset$MultipleLines)
dataset$PhoneServ <- revalue(dataset$PhoneServ, c('Yes Yes' = 'Multiple Lines', 'Yes No' = 'One Line', 'No No' = 'No Phone'))
dataset$Streaming<- paste(dataset$StreamingTV, dataset$StreamingMovies)
dataset$Streaming <- revalue(dataset$Streaming, c('Yes Yes' = 'TV & Movies', 'Yes No' = 'Only TV', 'No Yes' = 'Only Movies', 'No No' = 'No Streaming'))

# Adding Tenure Categories
library(dplyr)
dataset <- (mutate(dataset, tenure_group = ifelse(dataset$tenure %in% 0:12, "0-12 Months",
                                                  ifelse(dataset$tenure %in% 13:24, "13-24 Months",
                                                         ifelse(dataset$tenure %in% 25:36, "25-36 Months",
                                                                ifelse(dataset$tenure %in% 37:48, "37-48 Months",
                                                                       ifelse(dataset$tenure %in% 49:60, "49-60 Months","over 60 Months")))))))

dataset$tenure_group <- as.factor(dataset$tenure_group)

# Setting Churn Values
dataset$Churn = as.character(dataset$Churn)
dataset$Churn[dataset$Churn == 'No'] <- 'Stayed'
dataset$Churn[dataset$Churn == 'Yes'] <- 'Churn'


# # other data types
dataset$gender = as.character(dataset$gender)
dataset$Dependents = as.character(dataset$Dependents)
dataset$Partner = as.character(dataset$Partner)

# separating churn and non-churn customers
churn <- filter(dataset, Churn == 'Churn')
non_churn <- filter(dataset, Churn == 'Stayed')





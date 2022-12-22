########################################################
# 4-fold cross-validation for mtcars data: mpg ~ hp
# Author: Mattias Villani (https://mattiasvillani.com)
########################################################

# Setting up the folds
n = dim(mtcars)[1] # there are n = 32 observations in the dataset
random_order = sample(1:n) # This shuffles the order of the observations randomly

# Fold 1 - observations 1-8 used as test data
testfold = random_order[1:8] # These are the observation number for fold1
trainingfold = setdiff(random_order,testfold) # All the remaining obs are used for training
fit = lm(mpg ~ hp, subset = trainingfold, data = mtcars) # Here we fit the model using on the observation in trainingfold
yhat_fold1 = predict(fit, newdata = mtcars[testfold,]) # And here we predict the data in the first test fold

# Fold 2 - observations 9-16 used as test data
testfold = random_order[9:16]
trainingfold = setdiff(random_order,testfold)
fit = lm(mpg ~ hp, subset = trainingfold, data = mtcars)
yhat_fold2 = predict(fit, newdata = mtcars[testfold,])

# Fold 3 - observations 17-24 used as test data
testfold = random_order[17:24]
trainingfold = setdiff(random_order,testfold)
fit = lm(mpg ~ hp, subset = trainingfold, data = mtcars)
yhat_fold3 = predict(fit, newdata = mtcars[testfold,])

# Fold 4 - observations 25-32 used as test data
testfold = random_order[25:32]
trainingfold = setdiff(random_order,testfold)
fit = lm(mpg ~ hp, subset = trainingfold, data = mtcars)
yhat_fold4 = predict(fit, newdata = mtcars[testfold,])

yhat = c(yhat_fold1, yhat_fold2, yhat_fold3, yhat_fold4) # collecting all predictions
y = mtcars[random_order,1] # the actual mpg data

MSE = sum((y - yhat)^2)/n
RMSE = sqrt(MSE) # This is RMSE on all the test data


# Perform cross-validation using the course package sdakurs
library(sdakurs)
RMSE_CV = reg_crossval(mpg ~ hp, mtcars, nfolds = 4, obs_order = "random")
RMSE_CV


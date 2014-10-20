library(caret)

set.seed(83947)

data = read.csv("pml-training.csv", header = TRUE)
data <- data[ , ! apply(data , 2 , function(x) any(is.na(x)) ) ]
classe <- data$classe
data <- data[, grepl( "^roll|^pitch|^yaw|^total|^gyros|^accel|^magnet", names(data))]
data <- cbind(classe, data)

inTrain <- createDataPartition(data$classe, p=.2, list = FALSE)
training <- data[inTrain, ]
testing <- data[-inTrain, ]

fitControl <- trainControl(method = "cv",number = 10)
modelFit <- train(training$classe ~., method="rf", trControl = fitControl, data= training )
pred <- predict(modelFit, testing)
confusionMatrix(pred, testing$classe)

#preProc <- preProcess(training[,-1], method="pca", pcaComp=10)
#trainPC <- predict(preProc, training[,-1])
#modelFit <- train(training$classe ~. ,method="rf", data= trainPC )
#testPC <- predict(preProc, testing[,-1])
#confusionMatrix(testing$classe, predict(modelFit,testPC))

#fitControl <- trainControl(method = "cv",number = 10)
#gbmFit <- train(classe ~ ., data = training, 
#		method = "gbm",
#               trControl = fitControl,
#               verbose = FALSE)
#pred <- predict(fitControl, testing)

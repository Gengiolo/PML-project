library(caret)

set.seed(83947)

data = read.csv("pml-training.csv", header = TRUE)
data <- data[ , ! apply(data , 2 , function(x) any(is.na(x)) ) ]
classe <- data$classe
data <- data[, grepl( "^roll|^pitch|^yaw|^gyros", names(data))]  #|^accel|^magnet|^total
data <- cbind(classe, data)

inTrain <- createDataPartition(data$classe, p=.7, list = FALSE)
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

#testex <- read.csv("pml-testing.csv", header = TRUE)
#testex <- testex[, grepl( "^roll|^pitch|^yaw|^gyros", names(testex))]
#pml_write_files = function(x){
#  n = length(x)
#  for(i in 1:n){
#    filename = paste0("problem_id_",i,".txt")
#    write.table(x[i],file=filename,quote=FALSE,row.names=FALSE,col.names=FALSE)
#  }
#}

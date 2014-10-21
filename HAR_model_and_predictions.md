## The project work
Human Activity Recognition - HAR - has emerged as a key research area in the last years and is gaining increasing attention by the pervasive computing research community, especially for the development of context-aware systems.  
For this project we were supposed to use the "Weight Lifting Exercises Dataset" in which six young health participants were asked to perform one set of 10 repetitions of the Unilateral Dumbbell Biceps Curl in five different fashions: exactly according to the specification (Class A), throwing the elbows to the front (Class B), lifting the dumbbell only halfway (Class C), lowering the dumbbell only halfway (Class D) and throwing the hips to the front (Class E).
The goal of the project is to predict the manner in which they did the exercise. This is the "classe" variable in the training set.

----------------------------------------
<br>

## Exploring the data

The first thing to do is to understand the data and which feature could be useful for our purposes.
So we can load the caret package and the data contained in the "pml-training.csv" file.


```r
library(caret)
set.seed(83947)
data = read.csv("pml-training.csv", header = TRUE)
dim(data)
```

```
## [1] 19622   160
```
As you can see this is a huge dataset with a lots of records and variables. On one hand this means that it could be easier to build a good model on it, but on the other hand it could be really expensive in terms of computational resourses. 
Thus selecting which variable are better than others to predict the outcome could be really fundamental.
In fact, as you can see below (for the first raw as like the others) the data are not really clean.


```r
data[1,]
```

```
##   X user_name raw_timestamp_part_1 raw_timestamp_part_2   cvtd_timestamp
## 1 1  carlitos           1323084231               788290 05/12/2011 11:23
##   new_window num_window roll_belt pitch_belt yaw_belt total_accel_belt
## 1         no         11      1.41       8.07    -94.4                3
##   kurtosis_roll_belt kurtosis_picth_belt kurtosis_yaw_belt
## 1                                                         
##   skewness_roll_belt skewness_roll_belt.1 skewness_yaw_belt max_roll_belt
## 1                                                                      NA
##   max_picth_belt max_yaw_belt min_roll_belt min_pitch_belt min_yaw_belt
## 1             NA                         NA             NA             
##   amplitude_roll_belt amplitude_pitch_belt amplitude_yaw_belt
## 1                  NA                   NA                   
##   var_total_accel_belt avg_roll_belt stddev_roll_belt var_roll_belt
## 1                   NA            NA               NA            NA
##   avg_pitch_belt stddev_pitch_belt var_pitch_belt avg_yaw_belt
## 1             NA                NA             NA           NA
##   stddev_yaw_belt var_yaw_belt gyros_belt_x gyros_belt_y gyros_belt_z
## 1              NA           NA            0            0        -0.02
##   accel_belt_x accel_belt_y accel_belt_z magnet_belt_x magnet_belt_y
## 1          -21            4           22            -3           599
##   magnet_belt_z roll_arm pitch_arm yaw_arm total_accel_arm var_accel_arm
## 1          -313     -128      22.5    -161              34            NA
##   avg_roll_arm stddev_roll_arm var_roll_arm avg_pitch_arm stddev_pitch_arm
## 1           NA              NA           NA            NA               NA
##   var_pitch_arm avg_yaw_arm stddev_yaw_arm var_yaw_arm gyros_arm_x
## 1            NA          NA             NA          NA           0
##   gyros_arm_y gyros_arm_z accel_arm_x accel_arm_y accel_arm_z magnet_arm_x
## 1           0       -0.02        -288         109        -123         -368
##   magnet_arm_y magnet_arm_z kurtosis_roll_arm kurtosis_picth_arm
## 1          337          516                                     
##   kurtosis_yaw_arm skewness_roll_arm skewness_pitch_arm skewness_yaw_arm
## 1                                                                       
##   max_roll_arm max_picth_arm max_yaw_arm min_roll_arm min_pitch_arm
## 1           NA            NA          NA           NA            NA
##   min_yaw_arm amplitude_roll_arm amplitude_pitch_arm amplitude_yaw_arm
## 1          NA                 NA                  NA                NA
##   roll_dumbbell pitch_dumbbell yaw_dumbbell kurtosis_roll_dumbbell
## 1         13.05         -70.49       -84.87                       
##   kurtosis_picth_dumbbell kurtosis_yaw_dumbbell skewness_roll_dumbbell
## 1                                                                     
##   skewness_pitch_dumbbell skewness_yaw_dumbbell max_roll_dumbbell
## 1                                                              NA
##   max_picth_dumbbell max_yaw_dumbbell min_roll_dumbbell min_pitch_dumbbell
## 1                 NA                                 NA                 NA
##   min_yaw_dumbbell amplitude_roll_dumbbell amplitude_pitch_dumbbell
## 1                                       NA                       NA
##   amplitude_yaw_dumbbell total_accel_dumbbell var_accel_dumbbell
## 1                                          37                 NA
##   avg_roll_dumbbell stddev_roll_dumbbell var_roll_dumbbell
## 1                NA                   NA                NA
##   avg_pitch_dumbbell stddev_pitch_dumbbell var_pitch_dumbbell
## 1                 NA                    NA                 NA
##   avg_yaw_dumbbell stddev_yaw_dumbbell var_yaw_dumbbell gyros_dumbbell_x
## 1               NA                  NA               NA                0
##   gyros_dumbbell_y gyros_dumbbell_z accel_dumbbell_x accel_dumbbell_y
## 1            -0.02                0             -234               47
##   accel_dumbbell_z magnet_dumbbell_x magnet_dumbbell_y magnet_dumbbell_z
## 1             -271              -559               293               -65
##   roll_forearm pitch_forearm yaw_forearm kurtosis_roll_forearm
## 1         28.4         -63.9        -153                      
##   kurtosis_picth_forearm kurtosis_yaw_forearm skewness_roll_forearm
## 1                                                                  
##   skewness_pitch_forearm skewness_yaw_forearm max_roll_forearm
## 1                                                           NA
##   max_picth_forearm max_yaw_forearm min_roll_forearm min_pitch_forearm
## 1                NA                               NA                NA
##   min_yaw_forearm amplitude_roll_forearm amplitude_pitch_forearm
## 1                                     NA                      NA
##   amplitude_yaw_forearm total_accel_forearm var_accel_forearm
## 1                                        36                NA
##   avg_roll_forearm stddev_roll_forearm var_roll_forearm avg_pitch_forearm
## 1               NA                  NA               NA                NA
##   stddev_pitch_forearm var_pitch_forearm avg_yaw_forearm
## 1                   NA                NA              NA
##   stddev_yaw_forearm var_yaw_forearm gyros_forearm_x gyros_forearm_y
## 1                 NA              NA            0.03               0
##   gyros_forearm_z accel_forearm_x accel_forearm_y accel_forearm_z
## 1           -0.02             192             203            -215
##   magnet_forearm_x magnet_forearm_y magnet_forearm_z classe
## 1              -17              654              476      A
```

There are a lots of blank values and NA. After some more explorations I decided to remove all the variables affected by these problems and select only the variables directly connected to the sensors:


```r
data = read.csv("pml-training.csv", header = TRUE)
data <- data[ , ! apply(data , 2 , function(x) any(is.na(x)) ) ]
classe <- data$classe
data <- data[, grepl( "^roll|^pitch|^yaw|^gyros", names(data))]  
data <- cbind(classe, data)
```

Now what we have is only the cleaned data with few variables left:


```r
names(data)
```

```
##  [1] "classe"           "roll_belt"        "pitch_belt"      
##  [4] "yaw_belt"         "gyros_belt_x"     "gyros_belt_y"    
##  [7] "gyros_belt_z"     "roll_arm"         "pitch_arm"       
## [10] "yaw_arm"          "gyros_arm_x"      "gyros_arm_y"     
## [13] "gyros_arm_z"      "roll_dumbbell"    "pitch_dumbbell"  
## [16] "yaw_dumbbell"     "gyros_dumbbell_x" "gyros_dumbbell_y"
## [19] "gyros_dumbbell_z" "roll_forearm"     "pitch_forearm"   
## [22] "yaw_forearm"      "gyros_forearm_x"  "gyros_forearm_y" 
## [25] "gyros_forearm_z"
```
----------------------------------------
<br>
## Partitioning the data

Following the general rule in machine learning I decided to split the data in two different dataset, the training and the testing.
I chose to give a 70% of the samples to the training even if it was not strictly needed. In fact, also with only 1/10 of the data it would be possible to build an extremely accurate model (more than 94%).
Here's the command to split the data:


```r
inTrain <- createDataPartition(data$classe, p=.7, list = FALSE)
training <- data[inTrain, ]
testing <- data[-inTrain, ]
```
----------------------------------------
<br>
## Training the model with cross-validation

After some experimentations I understood that there was not real need to pre-process data.
I decided to build directly the model performing a 10-fold cross-validation that has proven to be the best cv choise (see next section).
As you can see in the code that follows I also decided to build the model with the random forest algorithm. It is really expensive in terms of computational time, but it's the best predictor for these data (lda for example can build the model almost instantaneously but its accuracy doesn't exceed the 70%).


```r
fitControl <- trainControl(method = "cv",number = 10)
modelFit <- train(training$classe ~., method="rf", trControl = fitControl, data= training)
modelFit
```

```
## Random Forest 
## 
## 13737 samples
##    24 predictors
##     5 classes: 'A', 'B', 'C', 'D', 'E' 
## 
## No pre-processing
## Resampling: Cross-Validated (10 fold) 
## 
## Summary of sample sizes: 12364, 12363, 12364, 12362, 12363, 12363, ... 
## 
## Resampling results across tuning parameters:
## 
##   mtry  Accuracy  Kappa  Accuracy SD  Kappa SD
##    2    0.992     0.990  0.002        0.003   
##   13    0.989     0.986  0.003        0.003   
##   24    0.986     0.982  0.003        0.004   
## 
## Accuracy was used to select the optimal model using  the largest value.
## The final value used for the model was mtry = 2.
```
As you can see the predicted accuracy is really hight. I will test it again in the next section using the completely new training dataset I constructed above.

----------------------------------------
<br>
## Predicting the data and out of samples error

So, The last two lines of code below are used to predict the data conteined in the testing dataset and to summarize the latest news about the accuracy.


```r
pred <- predict(modelFit, testing)
confusionMatrix(pred, testing$classe)
```

```
## Confusion Matrix and Statistics
## 
##           Reference
## Prediction    A    B    C    D    E
##          A 1670    9    1    1    0
##          B    2 1121    7    0    0
##          C    1    7 1010    8    1
##          D    1    2    8  951    2
##          E    0    0    0    4 1079
## 
## Overall Statistics
##                                         
##                Accuracy : 0.991         
##                  95% CI : (0.988, 0.993)
##     No Information Rate : 0.284         
##     P-Value [Acc > NIR] : <2e-16        
##                                         
##                   Kappa : 0.988         
##  Mcnemar's Test P-Value : NA            
## 
## Statistics by Class:
## 
##                      Class: A Class: B Class: C Class: D Class: E
## Sensitivity             0.998    0.984    0.984    0.987    0.997
## Specificity             0.997    0.998    0.997    0.997    0.999
## Pos Pred Value          0.993    0.992    0.983    0.987    0.996
## Neg Pred Value          0.999    0.996    0.997    0.997    0.999
## Prevalence              0.284    0.194    0.174    0.164    0.184
## Detection Rate          0.284    0.190    0.172    0.162    0.183
## Detection Prevalence    0.286    0.192    0.175    0.164    0.184
## Balanced Accuracy       0.997    0.991    0.990    0.992    0.998
```

It turns out that the model is incredibly accurate with a 99% of accuracy.
We can consider this estime credible due to the fact that I used cross validation during the training and tested the model with a completely new set of data. 



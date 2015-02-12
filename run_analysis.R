## This code attempts to do the following (in a non-sequential order):
## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement. 
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Read the various datasets
unzip("getdata-projectfiles-UCI HAR Dataset.zip")
trainingset = read.csv("./UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE)
traininglabels = read.csv("./UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE)
trainingsubject = read.csv("./UCI HAR Dataset/train/subject_train.txt", sep="" ,header=FALSE)
testset = read.csv("./UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE)
testlabels= read.csv("./UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE)
testsubject = read.csv("./UCI HAR Dataset/test/subject_test.txt", sep="" ,header=FALSE)

## Load the activity labels
activityLabels = read.csv("./UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
head(activityLabels)

## 3. Use descriptive activity names to name the activities in the data set
traininglabels$V1 <- factor(traininglabels$V1,levels=activityLabels$V1,labels=activityLabels$V2)
testlabels$V1 <- factor(testlabels$V1,levels=activityLabels$V1,labels=activityLabels$V2)

## Load the features labels
features = read.csv("./UCI HAR Dataset/features.txt", sep="" ,header=FALSE)
head(features)

## Merge the training/test data with their labels
trainData <- cbind(trainingsubject,traininglabels,trainingset)
testData <- cbind(testsubject,testlabels,testset)

## 1. Merge the training and the test sets to create one data set.
allData <- rbind(trainData,testData)

## 4. Appropriately label the data set with descriptive variable names.
colnames(allData) <- c("Subject","Activity",as.vector(features[,2]))

## 2. Extract only the measurements on the mean and standard deviation for each measurement. 
allData_mean <- sapply(allData,mean,na.rm=TRUE)
allData_sd <- sapply(allData,sd,na.rm=TRUE)

## 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
library(data.table)
datatable <- data.table(allData)
tidyData <- datatable[,lapply(.SD,mean),by="Activity,Subject"]
write.table(tidyData,file="tidydata.csv",sep=",",row.names = FALSE)

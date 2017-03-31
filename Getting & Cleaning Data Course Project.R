## Getting and Cleaning Data Course Project

## You should create one R script called run_analysis.R that does the following.
        ## 1	Merges the training and the test sets to create one data set.
        ## 2	Extracts only the measurements on the mean and standard deviation for each measurement. 
        ## 3	Uses descriptive activity names to name the activities in the data set
        ## 4	Appropriately labels the data set with descriptive variable names.
        ## 5	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



## Download files

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

## Unzip files

unzip(zipfile="./data/Dataset.zip",exdir="./data")

## Reading training tables:
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

## Reading test tables:
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

## Reading feature vector:
features <- read.table('./data/UCI HAR Dataset/features.txt')

## Reading activity labels:
activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

## Assigning column names:
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

## 1 Merge Data to one set

merge_train <- cbind(y_train, subject_train, x_train)
merge_test <- cbind(y_test, subject_test, x_test)
combinedData <- rbind(merge_train, merge_test)

## 2 Reading Column Names

colNames <- colnames(combinedData)

## 2 Defining Activity ID, Subject ID, Mean and Standard Deviation

mean_std <- (grepl("activityId" , colNames) | 
                         grepl("subjectId" , colNames) | 
                         grepl("mean.." , colNames) | 
                         grepl("std.." , colNames) 
)

## 2 Making Subset combined Data

DataMeanAndStd <- combinedData[ , mean_std == TRUE]

## 3 Make descriptive activity names to name the activities in the data set

DataWithActivityNames <- merge(DataMeanAndStd, activityLabels,
                              by='activityId',
                              all.x=TRUE)

## 4 Appropriately labels the data set with descriptive variable names

names(DataWithActivityNames)<-gsub("^t", "time", names(DataWithActivityNames))
names(DataWithActivityNames)<-gsub("^f", "frequency", names(DataWithActivityNames))
names(DataWithActivityNames)<-gsub("Acc", "Accelerometer", names(DataWithActivityNames))
names(DataWithActivityNames)<-gsub("Gyro", "Gyroscope", names(DataWithActivityNames))
names(DataWithActivityNames)<-gsub("Mag", "Magnitude", names(DataWithActivityNames))
names(DataWithActivityNames)<-gsub("BodyBody", "Body", names(DataWithActivityNames))


## 5.1  Make second, independent tidy data set with the average of each variable for each activity and each subject.

secondTidySet <- aggregate(. ~subjectId + activityId, DataWithActivityNames, mean)
secondTidySet <- secondTidySet[order(secondTidySet$subjectId, secondTidySet$activityId),]

## 5.2 Write second tidy data set into a .txt file

write.table(secondTidySet, "secTidySet.txt", row.name=FALSE)


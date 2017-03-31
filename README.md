Getting and Cleaning Data - Course Project

This is the course project for theData Science's track course Getting and Cleaning data

The dataset being used is the Human Activity Recognition Using Smartphones:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description of the data can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The R-Script `run_analysis.R`, does the following:

Downloads the data set if its not already existing in the working directory

Merges the training and the test sets to create one data set.

Extracts only the measurements on the mean and standard deviation for each measurement.

Makes descriptive activity names to name the activities in the data set

Appropriately labels the data set with descriptive variable names.

From the data set in the above step, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


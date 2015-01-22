## ##################################################################
#
# Getting and Cleaning Data Course Project
# January 2015
#
# Here are the data for the project:    
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 
# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# 
## ##################################################################



## 
# step 0.
# Defines local variables
# and downloads and prepares data sets
##

urlFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "./getdata_projectfiles_UCI HAR Dataset.zip"
dirFile <- "./UCI HAR Dataset"

resultFile <- "./tidyDatasetAVG.txt"

## downloads the data if it doesn't exist
if (!file.exists(zipFile)) 
{
    download.file(urlFile, destfile = zipFile)
}

## unzips the data if it is necessary
if (!file.exists(dirFile)) 
{
    unzip(zipFile)
}



## 
# step 1. 
# Merges the training and the test sets to create one data set
##

## loads training data
xTrainingData <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
yTrainingData <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
sTrainingData <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)

## loads test data
xTestData <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
yTestData <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
sTestData <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)

## combines both data sets (by row)
xData <- rbind(xTrainingData, xTestData)
yData <- rbind(yTrainingData, yTestData)
sData <- rbind(sTrainingData, sTestData)



## 
# step 2. 
# Extracts only the measurements on the mean and standard deviation for each measurement
##

## loads features
featuresData <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)
colnames(featuresData) <- c("id", "name")

## takes only 'mean()' and 'std()' columns
okColumns <- grep("-mean\\(\\)|-std\\(\\)", featuresData$name)
xData <- xData[, okColumns]

## sets the correct column names (without parenthesis)
colnames(xData) <- gsub("\\(|\\)", "", (featuresData[okColumns, 2]))



## 
# step 3. 
# Uses descriptive activity names to name the activities in the data set
##

## loads activities
activityData <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
colnames(activityData) <- c("id", "name")

## replaces activityId by activityName in yData data set
yData[, 1] = activityData[yData[, 1], 2]



## 
# step 4. 
# Appropriately labels the data set with descriptive variable names
##

## sets corect column names in yData and sData 
colnames(yData) <- c("activity")
colnames(sData) <- c("subject")




##
# step 5. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##

## aggregates the data
tidyData <- aggregate(xData, list(sData$subject, yData$activity), mean)
colnames(tidyData)[1] <- c("subject")
colnames(tidyData)[2] <- c("activity")

## writes the result file
write.table(tidyData, resultFile, row.name = FALSE)


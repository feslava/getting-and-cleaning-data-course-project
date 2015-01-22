## Getting and Cleaning Data Course Project CodeBook

This file describes the variables, the data, and any transformations or work that you performed to clean up the data.  

Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

And here a full description of the raw data (it's available at the site where the data was obtained): 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


The following steps describes the job:

(1) Load's the training data using the read.table() function (these file are in the ./train/ directory). These files generates the following data tables:
    X_train.txt (7352 rows, 561 columns)
    y_train.txt (7352 rows, 1 column)
    subject_train.txt (7352 rows, 1 column)
    
(2) Load's the test data using the read.table() function (these file are in the ./test/ directory).These files generates the following data tables:
    X_test.txt (2947 rows, 561 columns)
    y_test.txt (2947 rows, 1 column)
    subject_test.txt (2947 rows, 1 column)
    
(3) Combines these data sets by row, using the rbind() function. The result are the following data sets:
   xData (10299 rows, 561 columns)
   yData (10299 rows, 1 column)
   sData (10299 rows, 1 column)
   
(4) Extracts only the measurements on the mean and standard deviation for each measurement. Measurements are obtained loading the file './features.txt'. The loaded table has 561 rows and 2 columns and as the second column has the names of the measurements, I have used the grep() funtion to find measurements with mean() and std() names. There are only 66 measurements on the mean and standard deviation. The variable okColumns contains these measurement indexes.

(5) In order to use descriptive activity names to name the activities in the data set, I have used the data file './activity_labels.txt'. This file has been loaded using the data.table() funtion and it's dimensions are 6 rows and 2 columns. To obtain the descriptive names, activities id's found in the first column will be replaced by the names of the second one. Finally, the column of the 'yData' data table is renamed to 'activity' and the column of the 'sData' data table is renamed to 'subject'. 

(6) Creates a second, independent tidy data set with the average of each variable for each activity and each subject. This data will be created with the aggregate() function, will be stored in the 'tidyData' variable, and will generate a data table of 180 rows and 68 columns.

(7) Writes the result table using the write.table() function.


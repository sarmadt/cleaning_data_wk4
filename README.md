# cleaning_data_wk4

The project contains the script run_analysis.R that operates on data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script run_analysis.R does the following.

###Merges the training and the test sets to create one data set.
  This is done by read.table and merge commands, the activity labels and subjects are read separately
  
###Extracts only the measurements on the mean and standard deviation for each measurement.
  The script uses grepl to extract the relevant columns from the column/variable names
  then extracts the corresponding columns from the merged set. The script appends the subjects
  and activity columns to the extracted data at this poing
  
###Uses descriptive activity names to name the activities in the data set
 Uses a lambda function to map and replace the activity ids with the names 
  
###Appropriately labels the data set with descriptive variable names.
  Replaces original column names with the descriptive names read from the features.txt file
  
###From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  uses reshape2 package to achieve this

#read training and test data
train_data <- read.table("train/x_train.txt")
test_data <- read.table("test/x_test.txt")

#merge both
merged_data <- merge(train_data,test_data, all = TRUE)

#read train and test labels then merge them
train_labels <- read.table("train/y_train.txt")
test_labels <- read.table("test/y_test.txt")
merged_labels <- rbind(train_labels,test_labels)

#read train and test subjects then merge them
train_subjects <- read.table("train/subject_train.txt") 
test_subjects <- read.table("test/subject_test.txt")
merged_subjects <- rbind(train_subjects, test_subjects)

#read feature descriptions
features <- read.table("features.txt")

#select the features having mean() and std() using grepl
selected_features <- features[grepl('mean\\(|std', features$V2),]

#extract corresponding columns from merged data
extracted_data <- merged_data[,selected_features[[1]]]

#add subjects and activity columns to the extracted data
extracted_data$subjects <- merged_subjects$V1
extracted_data$activity <- merged_labels$V1

#read descriptive labels of activities
activity_labels <- read.table("activity_labels.txt")

#replace values with the labels in the activity column
extracted_data$activity <- sapply(extracted_data$activity, function(x) activity_labels$V2[x])

#get names of selected features followed by subjects and activity and assign them as
#column names to the extracted data
names(extracted_data) <- c(as.character(selected_features$V2), "subjects", "activity")
write.table(extracted_data, "extracted_data.txt")

#reshape data using reshape2 libarary
library(reshape2)

#convert to wide format by separating the id and measurement variables
ext_melt <- melt(extracted_data, id=c("subjects", "activity"), measure.vars=as.character(selected_features$V2))

#create new data frame using dcast providing mean of all measurement variables
#against id variables
new_df <- dcast(ext_melt, subjects + activity ~ variable, mean)
write.table(new_df, "new_data_frame.txt")

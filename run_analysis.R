## Course Project
## Getting and Cleaning Data 
## Johns Hopkins Coursera Data Science Track

## George Paloulian
## 06-21-2015

# Data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average 
#     of each variable for each activity and each subject.

# clear and reset the current environment (for reusability)
rm(list = ls())

# make sure working directory is set to current User's folder
setwd("~") # i.e. "/Users/paloul"

# Get or create the subdirectory in the current working directory
sub_path <- file.path("Dropbox", "Coursera", "GetCleanData_CourseProj")
wd_full_path <- file.path(getwd(), sub_path)
if (!file.exists(wd_full_path)) {
  dir.create(wd_full_path) # subpath does not exist, create it
}
setwd(wd_full_path) 

# download the file from the url
dest_file <- "UCI_HAR_dataset.zip"
data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(data_url, dest_file, method = "curl")

# unzip the data file, overwrite any previous data
unzip(dest_file, overwrite = TRUE)

# update the current working directory to point to unzipped parent folder, "UCI HAR Dataset"
setwd("UCI HAR Dataset")

# read in the data and assign custom columns to each data tables
features <- read.table('features.txt', header=FALSE); # read features.txt
colnames(features) <- c('features_id', 'features_label') # assign column labels to features

activity_label <- read.table('activity_labels.txt', header=FALSE); # read activity_labels.txt
colnames(activity_label) <- c('activity_id', 'activity_label') # assign column labels to activities

# read in the training data and assign meaningful column names
x_train <- read.table('train/x_train.txt', header=FALSE)
y_train <- read.table('train/y_train.txt', header=FALSE)
subject_train <- read.table('train/subject_train.txt', header=FALSE)
colnames(x_train) <- features[,2]
colnames(y_train) <- 'activity_id'
colnames(subject_train) <- 'subject_id'

# read in the test data and assign meaningful column names
x_test <- read.table('test/x_test.txt', header=FALSE)
y_test <- read.table('test/y_test.txt', header=FALSE)
subject_test <- read.table('test/subject_test.txt', header=FALSE)
colnames(x_test) <- features[,2]
colnames(y_test) <- 'activity_id'
colnames(subject_test) <- 'subject_id'

# merge y_train, subject_train, x_train to create one training data
data_train <- cbind(y_train, subject_train, x_train)
# merge y_test, subject_test, x_test to create one test data
data_test <- cbind(y_test, subject_test, x_test)

# merge data_train and data_test to create giant data set, completes bullet #1
data_final <- rbind(data_train, data_test) # Finished 1

# attempt to extract only mean and std deviation data for each measurement
col_names <- colnames(data_final)

# LogicalVector stating TRUE for the ID, mean() & stddev() columns and FALSE for all others
logical_column_vector = (grepl("activity..", col_names) | grepl("subject..", col_names) | grepl("-mean..", col_names) & !grepl("-meanFreq..", col_names) & !grepl("mean..-", col_names) | grepl("-std..", col_names) & !grepl("-std()..-", col_names));

# Subset the data_final table in order to extract only the columns that pertain to mean and stddeviation
data_final <- data_final[logical_column_vector == TRUE] # Finished 2

# merge the activity_labels with final_data by activity_id in order to describe activity names in the data set
data_final <- merge(activity_label, data_final, by = 'activity_id', all.x = TRUE) # Finished 3

# Update the colnames on data_final
col_names <- colnames(data_final)

# clean up the column names used in the final_data table by removing duplicates and parenthesis, 
# and expanding out f|t for freq and time for prefixes
for (i in 1:length(col_names)) # loop through the existing col_names and update the labels
{
  col_names[i] = gsub("\\()","", col_names[i])
  col_names[i] = gsub("-std$","StdDev", col_names[i])
  col_names[i] = gsub("-mean","Mean", col_names[i])
  col_names[i] = gsub("^(t)","time", col_names[i])
  col_names[i] = gsub("^(f)","freq", col_names[i])
  col_names[i] = gsub("([Gg]ravity)","Gravity", col_names[i])
  col_names[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body", col_names[i])
  col_names[i] = gsub("[Gg]yro","Gyro", col_names[i])
  col_names[i] = gsub("AccMag","AccMagnitude", col_names[i])
  col_names[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude", col_names[i])
  col_names[i] = gsub("JerkMag","JerkMagnitude", col_names[i])
  col_names[i] = gsub("GyroMag","GyroMagnitude", col_names[i])
}
# assign the updated col_names values to the data_final table
colnames(data_final) <- col_names # Finished 4

# create the final tidy data set for submission with average of each variable for each activity and subject
# Remove the activity_label column
data_tidy <- data_final[, names(data_final) != 'activity_label'];

# use aggregate to include the mean of each variable for each activity and each subject 
data_tidy <- aggregate(data_tidy[,names(data_tidy) != c('activity_id','subject_id')], by = list(activity_id = data_tidy$activity_id, subject_id = data_tidy$subject_id), mean)

# re-merge data_tidy columns with activity_label to include descriptive activity labels
data_tidy <- merge(activity_label, data_tidy, by = 'activity_id', all.x = TRUE) # Finished 5

# write the data_tidy to disk
write.table(data_tidy, 'data_tidy.txt', row.names = FALSE, sep = '\t') 
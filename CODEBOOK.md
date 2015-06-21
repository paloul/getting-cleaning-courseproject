# Getting and Cleaning Data Course Project

Getting and Cleaning Data Course Project submission repo

## Codebook Description

This file describes the variables, the data, and any transformations or work performed to clean up the data used in the Getting and Cleaning Data Course Project.

## The Original Data Set

The data for the project is retrieved from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "UCI HAR Dataset")

A full description of the data is available at the site where the data was obtained:
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Data Set Description snippet

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Attribute Information:

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

## Script Variables and Steps

Outline the steps taken to satisfy the 5 requirements of the Course project

### Merge the training and the test sets to create one data set

1. Read in the *features.txt* file without any headers (line 42)
2. Set custom column names using *colnames()* for the **features** variable
3. Read in the *activity_labels.txt* file without any headers
4. Set custom column names using *colnames()* for the **activity_label** variable
5. Read in *x_train.txt*, *y_train.txt*, and *subject_train.txt* under the training folder to x_train, y_train, and subject_train variables
6. Read in *x_test.txt*, *y_test.txt*, and *subject_test.txt* under the test folder to x_test, y_test, and subject_test variables
7. Set the column names of both *train* and *test* variables (x,y,subject) to labels found in features, *activity_id* and *subject_id* respectively
8. Use column bind (cbind) to combine the separate data columns spread across x, y, and subjects for test and training into two data sets named *data_train* and *data_test*
9. Use row bind (rbind) to combine all the rows in the training and test data sets into one, data_final.

### Extracts only the measurements on the mean and standard deviation for each measurement

1. Create a list of the column names found in *data_final* with variable *col_names*
2. Using the list of column names, create a logical vector, *logical_column_vector*, that determines which column names to utilize based on the search parameters given, i.e. "-mean", "-freq". 
3. Using the logical vector take a subset of *data_final*

### Uses descriptive activity names to name the activities in the data set

1. The existing *activity_label* variable represents the list of activities (ids and labels) that correspond to the ids in *data_final*
2. Using **merge()** add the activity labels column from *activity_labels* by=activity_id

### Appropriately labels the data set with descriptive variable names.

1. Using the updated *col_names* variable loop through all current column names in *data_final*
2. Check for matching expressions using gsub() for pattern matching and replacement in order to convert to meaningful versions for column names
3. Once complete, set the column names of *data_final* using colnames() with the variable *col_names*

### From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

1. Create the variable *data_tidy* that removes the activity label column
2. Use **aggregate()** grouped by activity_id and subject_id and calculate the mean for each numerical column representing the mean or std_deviation from inside *data_tidy*
3. Merge the activity label column back into *data_tidy* for ease of readability
4. Finally, output to file using *row.names=FALSE* to not show row numbers in output 

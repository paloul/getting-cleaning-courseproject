# Getting and Cleaning Data Course Project
Getting and Cleaning Data Course Project submission repo

## Summary

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

The project requires to submit the following
* A tidy data set as described below
* A link to a Github repository with your script for performing the analysis 
* A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.

## The Original Data Set

The data for the project is retrieved from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "UCI HAR Dataset")

A full description of the data is available at the site where the data was obtained:
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## Steps taken by the run_analysis.R script
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
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

## Steps taken by the run_analysis.R script on data set
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Execution Instructions
The script attempts to set the initial working directory to the user's home folder, *setwd("~")*, in order to keep things tidy (i.e. /Users/paloul). If this for some reason fails on your system, then comment out line 20 and the script should proceed accordingly with your default R working directory.

For my system, I have set the subsequent working directory to *Dropbox/Coursera/GetCleanData_CourseProj*. You can change this on line 23, though if it doesnt exist on your disk it will be created recursively via *dir.create(recursive=true)* under the root working directory.

Once you pass directory creation everything else is automated. 
1. The script will download the original data zip file to the working directory
2. Unzip the zip file to the working directory
3. Proceed with the steps detailed above
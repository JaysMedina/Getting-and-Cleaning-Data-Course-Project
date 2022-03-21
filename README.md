# Getting-and-Cleaning-Data-Course-Project
Repository for my Coursera: Getting and Cleaning Data Course Project submission

Getting and Cleaning Data - Course Project
==========================================

* This is the course project for the Getting and Cleaning Data Coursera course.
* The included R script, `run_analysis.R`, conducts the following:


1. Download the dataset from the web via the given link "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
2. Read both the train and test datasets and merge them into together.
3. Extract only mean and std data from the primary multi-columnar data x
4. Merge x, y(activity) and subject data. 
5. Clean y and subject columns to reflect "activity" and "subject" as their headers instead of "V1".
5. Generate 'Tidy Dataset' that consists of the average (mean) of each variable for each subject and each activity.
   The result is shown in the file `UCI-HAR-tidy-data.txt`.

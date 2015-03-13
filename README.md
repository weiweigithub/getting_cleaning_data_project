## Coursera Data Science Specialization Getting and Cleaning Data Course Project
This repository contains my submissiton to the project assignment

## Project Description
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.  

The dataset for the project can be downloaded at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

One of the most exciting areas in all of data science right now is wearable computing - see for example [this paper](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The given dataset represents data collected from the accelerometers from the Samsung Galaxy S smartphone.  

### It is required that following are submitted for peer evaluation:  

1. A tidy data set as described below.  
2. A link to a Github repository with your script for performing the analysis.  
3. A code book that describes the variables, the data, and any transformations or work that are performed to clean up the data called CodeBook.md.  
4. A README.md should also be inlcuded.  


### You should create one R script called run_analysis.R that does the following:  

1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.  
3. Uses descriptive activity names to name the activities in the data set.  
4. Appropriately labels the data set with descriptive activity names.  
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

### Solution design  

Step-by-step description of how the solution is implemented can be found in **CodeBook.md**. The summary of the solution is as follows:  

1. The original data files are downloaded and unzipped.  
2. The content, structure, and format of all the data files are carefully examined with the assistance of README file come with the download.  
3. dim(), str(), head() are used constantly to explore the connection between the data files to compose the big picture.  
4. Data is merged, cleaned, properly labeled as required.  
5. Final tidy data set is printed out into a file for submission.  



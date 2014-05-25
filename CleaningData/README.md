# Getting and Cleaning Data Course Project

##Summary:
This folder was put together to showcase a script: run_analysis.R
It's purpose is to automatically download, clean, and reshape a dataset for downstream analysis. The script only prerequisite is to be ran ina folder where the user has write access priviledges.

##Input: 
The script expects a link to the dataset zipped file
#Output: 
The script will create a csv file containing a tidy dataset. The data included is a transformation on a subset of the features of the original dataset. 

##Source:
The dataset being manipulated is available on the UC Irvine Center for Machine Learning and Intelligent Systems.
The Human Activity Recognition Using Smartphones Dataset is available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
For this class, hence this exercise, the dataset was made available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

##Features Selection
See CodeBook.md for detail.
##steps:
These are the steps taken by the script
* Verify the existence of a data folder. if the folder doesn't exist, it is created and set as default working folder
* Download the zipped dataset at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip in the data folder
* Unzip the file. This will create a "UCI HAR Dataset" folder
* Import all needed libraries
* Import the list of all the features and properly label the columns
* Derive the index of All features that describe either the mean or the standard deviation
* Import the labels categories
* Import and combine the subjects identifiers in both training and test sets
* Import the input of both training and test (X) and combine them
* Import the output of both training and test (Y) data and merge them
* Properly label all the colums in the X, Y, and subjects data
* Cbind the data and the labels in one tidy structure following (Subjects)(X)(Y) 
* Create the independent data set with the average of each variable for each activity and each subject
* Write the independant data frame to a csv file in the data folder

##Reference:
Lets give proper credit :)

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

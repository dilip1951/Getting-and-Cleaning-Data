Getting-and-Cleaning-Data
=========================

Project

The R script run_analysis.R  does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Labels the data set with descriptive activity names.
5. Creates a tidy data set with the average of each variable for each activity and each subject.

Steps:

1. Download the data in the working directory.  It creates UCI HAR Dataset folder with all of the data files..
2. The run_analysis.R  file is set in the working directory.  If it is not the directory is set to the working directory using setwd() function.
3. Running run_analysis.R generates a file tidy_data.txt in the working directory.

run_analysis.R uses reshape2 and data.table.


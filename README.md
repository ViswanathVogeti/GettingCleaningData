This document describes the functioning of the run_analysis.R script and provides instructions to execute it.

Overview of run_analysis.R Script: This R script reads different datasets containing the data associated with the samsung SII sensor, extracts only the required data from them, merges the datasets, add appropriate descriptive names to the variables, applies the mean function based on defined attributes and creates a tidy dataset.
  
Instructions to run run_analysis.R script.

1. The Samsung Dataset should be downloaded from the link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
2. The downloaded file should be then unzipped which will extract a folder "UCI HAR Dataset".
3. The run_analysis.R script should be placed inside the folder "UCI HAR Dataset" keeping all the subfolders intact.
4. The run_analysis.R script should be then ready for execution.

Input Datasets to the run_analysis.R:

1. train/X_train.txt - This dataset contains the measurements (meant for training purpose) calculated on the Samsung SII Sensor data for predefined set of activities performed by selected performers.
2. test/X_test.txt - This dataset contains the measurements (meant for testing purpose) calculated on the Samsung SII Sensor data for predefined set of activities performed by selected performers. 
3. train/y_train.txt - This contains the activity carried out for each of the observations in the training dataset.
4. test/y_test.txt  - This contains the activity carried out for each of the observations in the test dataset.
5. activity_labels.txt - This contains the data relating the activity label with the activity name.
6. train/subject_train.txt - Contains the subject data who carried out the activity for each observation on the training dataset.
7. test/subject_test.txt - Contains the subject data who carried out the activity for each observation on the test dataset.
8. features.txt - Contains the variable names for different measurements taken from the Samsung Sensor Data.


Functions of run_analysis.R:

1. Read the training and test datasets and load to respective dataframes.
2. Read the activity data for each of the observations in training & test data and load to respective dataframes.
3. Read the subject data for each of the observations in training and test data and load to the respective dataframes.
4. Join the Training & Test dataframes with the respective activity & subject dataframes.
5. Merge(Union) the Training and Test dataframes.
6. Read the variable names from the features.txt dataset and assign it to a dataframe.
7. Name the variable names of the merged dataframe with the names obtained from the features.txt dataset.
8. Subset the merged measurement dataframe by selecting only the mean and the standard deviation measurements.
9. Read the data from the activity_labels.txt dataset and assign it to a dataframe.
10. Join with the measurement dataframe and remove the activity label variable.
11. Give Proper Descriptive Names to the measurement dataframe.
12. Aggregate the measurement dataframe  based on the Activity and Subject and apply the mean to all the measure variables.
13. Rename the group columns of the resultant dataframe appropriately.
14. This will give raise to the desired tidy dataframe.


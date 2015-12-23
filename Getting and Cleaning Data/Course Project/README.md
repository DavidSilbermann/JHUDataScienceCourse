# README.md
## Getting and Cleaning Data Course Project

This project involved the combination and summarization of datasets. 

More information about the dataset can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

And the datasets themselves can be found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

At the outset of the project I unzipped the dataset to a folder called "UCI HAR Dataset" within my working directory.  The processing script assumes that the data is in this folder and its subfolders.

The processing script is called run_analysis.R.  run_analysis.R preforms the following operations:

Reads all of the data files used in the project.  These files include: 

        * test/X_test.txt and train/X_train.txt which contain observation data
        * test/Y_test.txt and train/Y_train.txt which contain the activity, as a numeric value, of the activity being performed.
        * test/subject_test.txt and train/subject_train.txt which contain a numeric identifier of the (human) subject.
        * activity_labels.txt which contains a mapping of numeric activity levels to human readable activity level (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).
        * features.txt which contains a list of the column names of the X_test.txt and X_train.txt datasets. 

Once all of the necessary dataset had been read, I used the rbind command to combine the testing and training datasets for the observation data, the activity data, and the subject data.  Care was taken to preserve the order of this data, training data first followed by test data.

Using the features data it was possible to name the column in the observation dataset.  This made interpretation much easier.

I used the cbind.data.frame command to combine the subject data, activity data and observation data into a single dataframe.

The mapvalue function was used to translate the numeric activity levels to strings (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).  And the factor function was used to make the subject and activity columns into factors.

The dplyr group_by function was used to group by subject and activity and then the dplyr summarize function was used to calculate the means of the Mean Body Accelerations and Standard Deviation for each subject, performing each activity along the X, Y and Z axis.

The dataframe was then written to a file called tidy_data.txt using the write.table command with the row.names = FALSE option.


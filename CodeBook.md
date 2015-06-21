# CodeBook
This file describes the code in run_analysis.R, including the variables, the data, and any transformations performed to clean the data.

# The data:
Wearable computing data collected from the accelerometers in Samsung Galaxy S smartphone from 30 different subjects. 

Complete description of the data can be found at:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The dataset was obtained from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Description of run.analysis variables and transformations
*variable names will be noted in "quotation marks"*

Goal: The tidy data is achieved in 5 steps using run_analysis.R and aims to summarize the mean and standard deviation measurements grouped by subject and activity type.

**Step 1 of 5:** Merges the training and the test sets to create one data set.
		*Read the following files: X_test.txt, subject_test.txt, y_test.txt which respectively contain the  561-feature vector, the subject ID, and activity type for the test set data.
		*create new column to classify historical usage as a test set (zero is test, 1 is training): "test$training_set"
		*read the descriptive variable names contained in the features.txt and convert it to a character data type: "featurelabels"
		*convert symbols in the "featurelabels" into periods using make.names function
		*Repeat the above steps for the training data set
		*Finally, merge the test and training data: "mergedData"

**Step 2 of 5:** the grep function is used to extract only the column names that contain 'mean..' or 'std' to extract measurements on mean and standard deviation for each measurement. 
		*'mean..' was used in order to exclude measurements of 'meanfrequency', which is a weighted average of the frequency components
		*the "mean" and "std" extracted measurements were merged into the "mergedSubset" dataframe

**Step 3 of 5:** Uses descriptive activity names to name the activities in the data set
		*The numbers in the dataframe associated with a descriptive activity are read in the  'activity_labels.txt'
		*mergedSubset is updated to include new columns for data on the the activity number("mergedData$activity") and subject ID ("mergedData$subject")
		*The data from activity_label is merged with the mergedData in order to provide desciptive activity names
		*In "mergedData", the subjectID and activity-related columns are renamed to 'subject' and 'activity', respectively

**Step 4 of 5**: Appropriately labels the data set with descriptive variable names. 
		*This was already completed from the code above.

**Step 5 of 5:** From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
		*the mergedSubset data is grouped by both subject and activity: "grouped" variable
		*"table" variable summarizes the grouped data by the mean
		*The activity columns is renamed to "activity_number" and subsequently deleted
		*This creates the final output: "tidy_table", which is saved as a txt file


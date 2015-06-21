#The following code creates tidy data from Wearable computing data collected from the accelerometers from the Samsung Galaxy S smartphone. Tidy data is achieved in 5 steps and aims to summarize the mean and standard deviation measurements by subject and activity type.

#CodeBook.md describes the variables, the data, and any transformations performed to clean the data
#README.md in the repo explains how all of the scripts work and how they are connected.

####### Step 1 of 5: Merges the training and the test sets to create one data set.
#This assumes the raw data is in the working directory
#Load necessary packages
library(dplyr)

### Part A: Create data frame for test data
feature_test = read.table('test/X_test.txt') #test set: 561-feature vector with time and frequency domain variables.  
subject_test = read.table('test/subject_test.txt') #identifies the subject who performed the activity 
activity_test = read.table('test/y_test.txt') #activity label 
test = data.frame(feature_test, subject_test, activity_test) #merges the test data

#create new column to classify historical usage as a test set (zero is test, 1 is training)
test$training_set = 0

#label the columns with descriptive variable names. 
featurelabels = read.table('features.txt') #load the descriptive names
featurelabels = as.character(featurelabels$V2)
featurelabels = make.names(featurelabels, unique = FALSE, allow_ = TRUE) #clean up the names
colnames(test) = c(featurelabels, 'subject', 'activity', 'training_set') #order matters here


#### Part B:  Create data.frame for training data
feature_train = read.table('train/X_train.txt') #test set: 561-feature vector with time and frequency domain variables
subject_train = read.table('train/subject_train.txt') #identifies the subject who performed the activity 
activity_train = read.table('train/y_train.txt') #activity label 
train = data.frame(feature_train, subject_train, activity_train) #merge the training data

#create new column to classify historical usage as a training set
train$training = 1

#label the training data columns
colnames(train) = c(featurelabels, 'subject', 'activity', 'training_set') #order matters here

## Finally, merge the test and training data
mergedData = rbind(test, train)


######Step 2 of 5: Extracts only the measurements on the mean and standard deviation for each measurement. 
mean = mergedData[,grep('mean..', colnames(mergedData), fixed = TRUE), ]
std = mergedData[,grep('std', colnames(mergedData), fixed = TRUE), ]
mergedSubset = cbind(mean, std)


######Step 3 of 5: Uses descriptive activity names to name the activities in the data set
#load activity labels associated with each number
activityLabels = read.table('activity_labels.txt')
mergedSubset = cbind(mergedSubset, mergedData$activity, mergedData$subject)

#Merge the descriptors with the data
mergedSubset = merge(mergedSubset, activityLabels, by.x = 'mergedData$activity', by.y = 'V1')
mergedSubset = rename(mergedSubset, activity = V2)
names(mergedSubset)[names(mergedSubset) == 'mergedData$subject'] = 'subject'


######Step 4 of 5: Appropriately labels the data set with descriptive variable names. 
##This was already completed from the code above.


######Step 5 of 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
grouped = group_by(mergedSubset, subject, activity)
table = summarise_each(grouped, funs(mean))
colnames(table)[3] <- "activity_number"
tidy_table = subset(table, select = -activity_number) #remove extraneous columns
write.table(tidy_table, file = "tidy_table.txt", row.name = FALSE) #save as txt


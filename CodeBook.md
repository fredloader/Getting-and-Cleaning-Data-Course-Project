We will be working on the dataset from the UCI Machine Learning Repository on the Human Activity Recognition Using Smartphones study: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

  where:
 		X_test.txt is the Test dataset
 		y_test.txt contains the Test labels (activity)
 		subject_test.txt contains the subjects who performed the activity
 		features.txt contains feature information

The feature names were read in first as we will use it for both the Test and Training sets

The test data sets X_test.txt, y_test.txt and subject_test.txt were read into tables with "Test" prefixes.
The test Subjects and Labels tables were combined with Test data. The first two columns of the data set has the Subject and Activity measurements.

The train data sets X_train.txt, y_train.txt and subject_train.txt were read into tables with "Train" prefixes.
The train Subjects and Labels were combined with Train data. The first two columns of the data set has the Subject and Activity measurements.

Next, the training and the test sets were merged to a data set called "MyData1", column names were replaced with feature names and the first two columns were labeled as "subject" and "activity".

Extractions were performed only on the mean and standard deviation for each measurement. Columns were identified that contained "mean()" and "std()".  The "search" measurement vector, sMeasure, was used with a "vectorized" version of grep that allowed to search for the columns we want: those with "mean()" and "std()". I got this idea from http://stackoverflow.com/questions/20440915/subsetting-data-frame-based-on-search-pattern-in-vector/20441800#20441800

Upon inspection, column names with "MeanFreq()" were copied over. So, these columns were dropped. We then used descriptive activity names to name the activities in the data set ("STANDING", etc.) The ActCode (for "Activity Code") column was dropped, too, as we now have a descriptive Activity column.

Lastly, a second, independent tidy data set with the average of each variable for each activity and each subject was created with the use of the "reshape2" library. The data set was "melt" and the Subject and Activity columns were defined as ID variables. "dcast" was then used afterwards to get the aggregates for the mean values for each subject and each activity.

The tidy data set was then written to a text file.

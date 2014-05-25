We will be working on the dataset from the UCI Machine Learning Repository on the Human Activity Recognition Using Smartphones study: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

  where:
 		X_test.txt is the Test dataset
 		y_test.txt contains the Test labels (activity)
 		subject_test.txt contains the subjects who performed the activity
 		features.txt contains feature information

Let's read in the feature names first as we will use it for both the Test and Training sets

Next, let's read in the test data sets X_test.txt, y_test.txt and subject_test.txt into tables with "Test" prefixes.
Then, we will combine Subjects and Labels with Test data. The first two columns of this data set will have the Subject and Activity measurements.

We will read in the train data sets X_train.txt, y_train.txt and subject_train.txt into tables with "Train" prefixes.
Then, we will combine Subjects and Labels with Train data. The first two columns of this data set will have the Subject and Activity measurements.

Now, merge the training and the test sets to create a data set called "MyData1", replace column names with feature names
and label the first two columns as "subject" and "activity".

Next, we will extract only the measurements on the mean and standard deviation for each measurement. Let's identify columns that have "mean()" and "std()" and set the "search" measurement vector, sMeasure. Using a "vectorized" version of grep will allow us to search for the columns we want, those with "mean()" and "std()". I got this idea from http://stackoverflow.com/questions/20440915/subsetting-data-frame-based-on-search-pattern-in-vector/20441800#20441800

Upon inspection, column names with "MeanFreq()" were copied over. So, we will take these columns out. Then use descriptive activity names to name the activities in the data set ("STANDING", etc.) We can now drop the ActCode column as we now have a descriptive Activity column.

Lastly, we will create a second, independent tidy data set with the average of each variable for each activity and each subject and for this, we will use the "reshape2" library. We will "melt" the data set and set the Subject and Activity  columns as ID variables, then use "dcast" to get the aggregates for the mean values for each subject and each activity.

The last step is to write the "tidy" data set to a text file.

run_analysis.R is the script we will run for the course project.

On line 11, let's read in the feature names first as we will use it for both the Test and Training sets

On line 14, let's read in the test data sets X_test.txt, y_test.txt and subject_test.txt into tables with "Test" prefixes.
Then, we will combine Subjects and Labels with Test data. The first two columns of this data set will have the Subject and Activity measurements.

On line 22, we will read in the train data sets X_train.txt, y_train.txt and subject_train.txt into tables with "Train" prefixes. Then, we will combine Subjects and Labels with Train data. The first two columns of this data set will have the Subject and Activity measurements.

On line 31, we will merge the training and the test sets to create a data set called "MyData1", replace column names with feature names and label the first two columns as "subject" and "activity".

Beginning on line 43 , we will extract only the measurements on the mean and standard deviation for each measurement. Let's identify columns that have "mean()" and "std()" and set the "search" measurement vector, sMeasure. Using a "vectorized" version of grep will allow us to search for the columns we want, those with "mean()" and "std()". I got this idea from http://stackoverflow.com/questions/20440915/subsetting-data-frame-based-on-search-pattern-in-vector/20441800#20441800

Upon inspection, column names with "MeanFreq()" were copied over. So, we will have to drop these columns. 
On lines 63 - 70, I set up a loop to search and then delete columns with occurences of "MeanFreq()". 
On lines 75 - 85, I then used descriptive activity names to name the activities in the data set ("STANDING", etc.) We can now drop the ActCode ("Activity Code") column as we now have a descriptive Activity column.

On lines, 89 -91, I searched for the following abbreviated terms and made descriptive changes:
"Acc", "Mag" and "Gyro" were changed to "Acceleration", "Magnitude" and "Gyroscope"

On lines 95 - 101, we will create a second, independent tidy data set, tidyData, with the average of each variable for each activity and each subject and for this, we will use the "reshape2" library. We will "melt" the data set and set the Subject and Activity  columns as ID variables, then use "dcast" to get the aggregates for the mean values for each subject and each activity.

On line 104, the last step is to write the "tidy" data set to a text file.

Study design

The datasets for this course project are from the UCI Machine Learning Repository on the Human Activity Recognition Using Smartphones study: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Where:
X_test.txt is the Test dataset
y_test.txt contains the Test labels (activity)
subject_test.txt contains the subjects who performed the activity
features.txt contains feature information

Data Set Information (from the UCI web site):

A group of 30 volunteers with an age bracket of 19-48 years performed the experiments. Six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) were performed by each person while wearing a smartphone (Samsung Galaxy S II) on the waist. 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured using its embedded accelerometer and gyroscope. To label the data manually, the experiments have been video-recorded.  70% of the volunteers were selected for generating the training data and 30% for the test data of the randomly partitioned dataset.

A pre-processing stage by applying noise filters and then sampling in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window) were applied on the sensor signals (accelerometer and gyroscope). A Butterworth low-pass filter were applied to body acceleration and gravity to separate the sensor acceleration signal, which has gravitational and body motion components. A filter with 0.3 Hz cutoff frequency was used since the gravitational force is assumed to have only low frequency components. A vector of features was obtained by calculating variables from the time and frequency domain from each window.

Code Book

The Instruction List (Pseudocode)
(run_analysis.R contains full comments on what particular sections of the script is performing)

The feature names were read in first as it will be used it for both the Test and Training sets.

The test data sets X_test.txt, y_test.txt and subject_test.txt were read into tables with "Test" prefixes.
The test Subjects and Labels tables were combined with Test data. The first two columns of the data set has the Subject and Activity measurements.

The train data sets X_train.txt, y_train.txt and subject_train.txt were read into tables with "Train" prefixes.
The train Subjects and Labels were combined with Train data. The first two columns of the data set has the Subject and Activity measurements.

Next, the training and the test sets were merged to a data set called "MyData1", column names were replaced with feature names and the first two columns were labeled as "subject" and "activity".

Column extractions were performed only on the mean and standard deviation for each measurement. Columns were identified that contained "mean()" and "std()".  The "search" measurement vector, sMeasure, was used with a "vectorized" version of grep that allowed to search for the columns we want: those with "mean()" and "std()". I got this idea from http://stackoverflow.com/questions/20440915/subsetting-data-frame-based-on-search-pattern-in-vector/20441800#20441800

Upon inspection, column names with "MeanFreq()" were copied over. So, these columns were dropped. We then used descriptive activity names to name the activities in the data set ("STANDING", etc.) The ActCode (for "Activity Code") column was dropped, too, as we now have a descriptive Activity column.

The merged dataset is now 68 columns, down from the original 563 columns.

In order to label the data set with descriptive activity names, I searched for the following abbreviated terms and made descriptive changes: "Acc", "Mag" and "Gyro" were changed to "Acceleration", "Magnitude" and "Gyroscope"

Lastly, a second, independent tidy data set, tidyData, with the average of each variable for each activity and each subject was created with the use of the "reshape2" library. The data set was "melt" and the Subject and Activity columns were defined as ID variables. "dcast" was then used afterwards to get the aggregates for the mean values for each subject and each activity.

The tidy data set was then written to a text file.

tidyData Structure:

Subject                                  : num
Activity                                 : chr
tBodyAcceleration-mean()-X               : num
tBodyAcceleration-mean()-Y               : num
tBodyAcceleration-mean()-Z               : num
tGravityAcceleration-mean()-X            : num
tGravityAcceleration-mean()-Y            : num
tGravityAcceleration-mean()-Z            : num
tBodyAccelerationJerk-mean()-X           : num
tBodyAccelerationJerk-mean()-Y           : num
tBodyAccelerationJerk-mean()-Z           : num
tBodyGyroscope-mean()-X                  : num
tBodyGyroscope-mean()-Y                  : num
tBodyGyroscope-mean()-Z                  : num
tBodyGyroscopeJerk-mean()-X              : num
tBodyGyroscopeJerk-mean()-Y              : num
tBodyGyroscopeJerk-mean()-Z              : num
tBodyAccelerationMagnitude-mean()        : num
tGravityAccelerationMagnitude-mean()     : num
tBodyAccelerationJerkMagnitude-mean()    : num
tBodyGyroscopeMagnitude-mean()           : num
tBodyGyroscopeJerkMagnitude-mean()       : num
fBodyAcceleration-mean()-X               : num
fBodyAcceleration-mean()-Y               : num
fBodyAcceleration-mean()-Z               : num
fBodyAccelerationJerk-mean()-X           : num
fBodyAccelerationJerk-mean()-Y           : num
fBodyAccelerationJerk-mean()-Z           : num
fBodyGyroscope-mean()-X                  : num
fBodyGyroscope-mean()-Y                  : num
fBodyGyroscope-mean()-Z                  : num
fBodyAccelerationMagnitude-mean()        : num
fBodyBodyAccelerationJerkMagnitude-mean(): num
fBodyBodyGyroscopeMagnitude-mean()       : num
fBodyBodyGyroscopeJerkMagnitude-mean()   : num
tBodyAcceleration-std()-X                : num
tBodyAcceleration-std()-Y                : num
tBodyAcceleration-std()-Z                : num
tGravityAcceleration-std()-X             : num
tGravityAcceleration-std()-Y             : num
tGravityAcceleration-std()-Z             : num
tBodyAccelerationJerk-std()-X            : num
tBodyAccelerationJerk-std()-Y            : num
tBodyAccelerationJerk-std()-Z            : num
tBodyGyroscope-std()-X                   : num
tBodyGyroscope-std()-Y                   : num
tBodyGyroscope-std()-Z                   : num
tBodyGyroscopeJerk-std()-X               : num
tBodyGyroscopeJerk-std()-Y               : num
tBodyGyroscopeJerk-std()-Z               : num
tBodyAccelerationMagnitude-std()         : num
tGravityAccelerationMagnitude-std()      : num
tBodyAccelerationJerkMagnitude-std()     : num
tBodyGyroscopeMagnitude-std()            : num
tBodyGyroscopeJerkMagnitude-std()        : num
fBodyAcceleration-std()-X                : num
fBodyAcceleration-std()-Y                : num
fBodyAcceleration-std()-Z                : num
fBodyAccelerationJerk-std()-X            : num
fBodyAccelerationJerk-std()-Y            : num
fBodyAccelerationJerk-std()-Z            : num
fBodyGyroscope-std()-X                   : num
fBodyGyroscope-std()-Y                   : num
fBodyGyroscope-std()-Z                   : num
fBodyAccelerationMagnitude-std()         : num
fBodyBodyAccelerationJerkMagnitude-std() : num
fBodyBodyGyroscopeMagnitude-std()        : num
fBodyBodyGyroscopeJerkMagnitude-std()    : num

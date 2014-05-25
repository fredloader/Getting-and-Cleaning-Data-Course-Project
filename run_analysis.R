## run_analysis.R: This is the script we will run for the project

## We will work on the Test datasets 
## Where:
## 		X_test.txt is the Test dataset
## 		y_test.txt contains the Test labels (activity)
## 		subject_test.txt contains the subjects who performed the activity
## 		features.txt contains feature information

## Let's read in the feature names first as we will use it for both the Test and Training sets
Features <- read.table("features.txt", header = FALSE, colClasses = "character")

## Read in the Test sets 
TestData <- read.table("./test/X_test.txt", header = FALSE, colClasses = "numeric")
TestLabels <- read.table("./test/y_test.txt", header = FALSE, colClasses = "numeric")
TestSubjects <- read.table("./test/subject_test.txt", header = FALSE, colClasses = "numeric")

## Combine Subjects and Labels with TestData
Test <- cbind(TestSubjects, TestLabels, TestData)

## Read in the Train sets
TrainData <- read.table("./train/X_train.txt", header = FALSE, colClasses = "numeric")
TrainLabels <- read.table("./train/y_train.txt", header = FALSE, colClasses = "numeric")
TrainSubjects <- read.table("./train/subject_train.txt", header = FALSE, colClasses = "numeric")

## Combine Subjects and Labels with Train data
Train <- cbind(TrainSubjects, TrainLabels, TrainData)

## 1.	Merge the training and the test sets to create one data set
##
MyData1 <- rbind.data.frame(Test, Train)

## Replace column names with feature names
## and insert columns with "subject" and "activity"
tnames <- Features[,2]
tnames <- c("subject", "activity", tnames)
names(MyData1) <- tnames

## 2.	Extract only the measurements on the mean and standard deviation for each measurement.
##
## Identify columns that have "mean()" and "std()"
## Let's set the "search" measurement vector, sMeasure 
sMeasure <- c("mean()", "std()")

## Next, let's create a "vectorized" version of grep
## This will allow us to search for the columns we want, those with "mean()" and "std()"
vGrep <- Vectorize(grep, vectorize.args="pattern")

## This will display column numbers that has "mean()" and "std()"
# vGrep(sMeasure, names(MyData1))
 
## This will display matching search results with measurements
## And then insert "subject" and "activity" columns from MyData1, then rename the columns
MyData1 <- cbind(MyData1$subject, MyData1$activity, MyData1[,unlist(vGrep(sMeasure, names(MyData1)))])
colnames(MyData1)[1] <- "Subject"
colnames(MyData1)[2] <- "ActCode"


## Upon inspection, column names with "MeanFreq()" were copied
## So, we will have to take these columns out
## Firt, loop until the length of "MeanFreq()" is not equal to 1 (there is a column name with "MeanFreq()" in it
## Then, delete the first "found" column. Keep on going until there are no more matches
repeat {
lmf <- length(vGrep("meanFreq()", names(MyData1)))
colMeanFreq <- vGrep("meanFreq()", names(MyData1))
MyData1[, colMeanFreq[1]] <- NULL
	if (lmf == 1){ 
		break
	}
}
  
## 3.    Use descriptive activity names to name the activities in the data set
##
## Let's read in the activity_labels.txt
Activity <- read.table("activity_labels.txt", header = FALSE, colClasses = "character")
## Create a vector for the column names
ActNames <- c("ActCode","Activity")
Activity <- read.table("activity_labels.txt", header = FALSE, colClasses = "character", col.names = ActNames )
## Merge the data sets to create a new, descriptive column "Activity"
MyDataMerge <- merge(MyData1, Activity, by.x="ActCode", by.y="ActCode")
## Let's drop the ActCode column,
MyDataMerge$ActCode <- NULL
## and move the "Activity" column from last to first
ColIndex <- grep("Activity", names(MyDataMerge))
MyDataMerge <- MyDataMerge[, c(ColIndex, (1:ncol(MyDataMerge))[-ColIndex])]

## 4.    Appropriately label the data set with descriptive activity names. 
##
names(MyDataMerge) <- gsub("Acc", "Acceleration", names(MyDataMerge))
names(MyDataMerge) <- gsub("Mag", "Magnitude", names(MyDataMerge))
names(MyDataMerge) <- gsub("Gyro", "Gyroscope", names(MyDataMerge))

## 5.    Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
## Load the "reshape2" library
library(reshape2)

## "Melt" the data set and set the Activity and Subject columns as ID variables 
MyData2 <- melt(MyDataMerge, id.vars = c("Subject", "Activity"))

## then use "dcast" to get the aggregates for the mean values for each subject and each activity
tidyData <- dcast(MyData2, Subject + Activity ~ variable, fun.aggregate=mean)

## Write the file when done
write.table(tidyData, file = "tidy.txt")

#########################################################################################################################
# According to the requirements, this project is executed in 5 steps described as follows.
# Step 1: Merges the traning and the test sets to create on data set
# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement
# Step 3: Use descriptive activity names to name the activities in the data set
# Step 4: Appropriately labels the data set with descriptive activity names
# Step 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject
#########################################################################################################################

library(dplyr)

###################### Step 1: Merges the traning and the test sets to create on data set###############################

## First, download the and unzip the data set using the given URL into local directory with name getcleanproject

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile="./rawdataset.zip")
unzip(zipfile="./rawdataset.zip", exdir=".")

## It was discovered that the unzipped files are in the sub folder titled as UCI HAR Dataset in the working directory
## The working directory is set to the directory where the data files are

newwd<-paste(getwd(), "/UCI HAR Dataset", sep="")
setwd(newwd)

## Upon examining the data files and REAME file, the connection between data files are sorted out. 
## The data on subjects (who are the participants of the experiment), the activities (basically 6 different modes when the measurements are taken)
## and the features (561 measured variables used in the expriment) are read from corresponding files inlcuding both training set and test set
## Notice that the orginal headers are NOT read, because they are going to be renamed more appropriately later.

testActivity<-read.table("./test/y_test.txt", header=FALSE)
trainActivity<-read.table("./train/y_train.txt", header=FALSE)

testSubject<-read.table("./test/subject_test.txt", header = FALSE)
trainSubject<-read.table("./train/subject_train.txt", header = FALSE)

testFeature<-read.table("./test/X_test.txt", header =FALSE) # Dimension is 2947*561
trainFeature<-read.table("./train/X_train.txt", header = FALSE) # Dimension is 7352*561

## As required, the corresponding training data and test data are merged into one. 
## Therefore, there are 3 intermediate merged files, one for subject, one for activity, one for variables (features).

allActivity <- rbind(testActivity, trainActivity)
allSubject<-rbind(testSubject, trainSubject)
allFeature<-rbind(testFeature, trainFeature)

## Merged subject and activity datasets only have one column, they are properly named.
colnames(allSubject)<-c("subject")
colnames(allActivity)<-c("activity")

## The names of all the measured variables are read from features.txt file and used for renaming merged data set of variables.
features<-read.table("./features.txt", header=FALSE)
colnames(allFeature)<-features$V2

## Finally, subject, activity and features are column binded into one data set. Each row of this dataset represents for a specific 
## person in the experiment in a specifi mode, all the 561 measurements he/she gets.
merged<-cbind(cbind(allActivity,allSubject), allFeature)

#############Step 2: Extracts only the measurements on the mean and standard deviation for each measurement###############

## Out of the 561 measurements, extract the means and stds as required. There are 66 in total, 33 for means and 33 for stds
featurenames<- features$V2
meanfeatures<-featurenames[grep("mean\\()", featurenames)]
stdfeatures<-featurenames[grep("std\\()", featurenames)]

## Subject and activity need to added to the list of required variables. 
requirednames<-c("subject", "activity")
for(i in 1:length(meanfeatures)) requirednames[i+2]=as.character(meanfeatures[[i]])
for(i in 1:length(stdfeatures)) requirednames[i+2+length(stdfeatures)]=as.character(stdfeatures[[i]])

## Get the proper subset of the data
extracted<-subset(merged, select = requirednames)


####################Step 3: Use descriptive activity names to name the activities in the data set##########################

## In the extracted dataset, activities are labels with integer from 1 to 6. Use information from activity_labels.txt, they 
## labeled with the actual name of the 6 modes
activities<-read.table("./activity_labels.txt", header=FALSE)

for (i in 1:nrow(activities)){
        extracted$activity<-gsub(i, activities[i,2], extracted$activity)
}

extracted$activity<-factor(extracted$activity)

##################Step 4: Appropriately labels the data set with descriptive activity names###############################

## Based on the information in README.md, attributes are more properly named
names(extracted)<-gsub("^t", "time", names(extracted))
names(extracted)<-gsub("^f", "frequency", names(extracted))
names(extracted)<-gsub("Acc", "Accelerometer", names(extracted))
names(extracted)<-gsub("Gyro", "Gyroscope", names(extracted))
names(extracted)<-gsub("Mag", "Magnitude", names(extracted))
names(extracted)<-gsub("BodyBody", "Body", names(extracted))

##Step 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject##

## Calculate mean of each variable by subject and by activity
final<-aggregate(extracted[,3:ncol(extracted)], by=list(subject = extracted$subject,activity=extracted$activity), mean)

## Reorder the data set to make it more intuitive to read. The dimension of the final data set is 180*68
tidy<-arrange(final, subject, activity)

## Print the final data set to a file as requied
write.table(tidy, file="tidydata.txt", row.name=FALSE)

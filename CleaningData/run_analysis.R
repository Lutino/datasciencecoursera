## Prepare script
# Verify existence of data folder, 
if(!file.exists("data")){dir.create("data")}
# Move to data folder
setwd("./data")
# Download the dataset and ...
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="UCIHARDataset.zip",method="curl")
# Unxip file. This will create a "UCI HAR Dataset" folder
unzip("UCIHARDataset.zip")
# Move out of the data folder
setwd("..")
# Import all needed libraries
library(reshape2)
library(plyr)

# Step1: Import all the features
features <- read.csv("./data/UCI HAR Dataset/features.txt",sep=" ",header=FALSE)
colnames(features) <- c("id","name")

# Step2: Pull the index of features that describe either the mean or the standard deviation
features.mean <- grep("mean()",features$name)
features.std <- grep("std()",features$name)

# Step3: Import the labels
activities.labels <- read.csv("./data/UCI HAR Dataset/activity_labels.txt",sep=" ",header=FALSE)
colnames(activities.labels) <- c("id","label")

# Step4: Import the subjects identifiers
training.subjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", colClasses="numeric")
test.subjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", colClasses="numeric")
#  ... and combine them in the order Training data , then Test Data
subjects <- rbind(training.subjects, test.subjects);

# Step5: Import the Training and Test X (Input) data
training.X <- read.table("./data/UCI HAR Dataset/train/X_train.txt", colClasses="numeric")
test.X <- read.table("./data/UCI HAR Dataset/test/X_test.txt", colClasses="numeric")

# Step6: Import the Training and Test Y (Output) data ...
training.y <- read.table("./data/UCI HAR Dataset/train/y_train.txt", colClasses="numeric")
test.y<- read.table("./data/UCI HAR Dataset/test/y_test.txt", colClasses="numeric")
#  ... and combine them in the order Training data , then Test Data
y.data <- rbind(training.y, test.y);

# Step 7: label the colums in the X data
colnames(training.X) <- features$name
colnames(test.X) <- features$name

# Step 8: subset both training and test data per the reduced list of features of step 2 above
trainingX.means <- training.X[,features.mean]
trainingX.stds <- training.X[,features.std]

testX.means <- test.X[,features.mean]
testX.stds <- test.X[,features.std]

# Step9: Merge all the subsetted data to form new reduced data frame
extracted.trainingData <- cbind (trainingX.means,trainingX.stds)
extracted.testData <- cbind (testX.means,testX.stds)

X.data <- rbind(extracted.trainingData,extracted.testData)

# Step10: combine the data and the labels in one tidy structure ...
extracted.data <- cbind (subjects,X.data,y.data)
# ... and label the first and last columns
colnames(extracted.data)[1] <- "idSubject"
colnames(extracted.data)[81] <- "idActivity"

# Step11 : Merge the activities into the extracted data so to carry over the descriptive activity names
extracted.measurements <- merge (extracted.data, activities.labels, by.x="idActivity", by.y="id")

# Step12: Create the independent data set with the average of each variable for each activity and each subject. 
independant.data<- melt(extracted.measurements, id = c("idSubject", "label"))
independant.data<- dcast(independant.data, idSubject + label ~ variable, mean)

# Step13: write the independant data frame to a csv file
setwd("./data/UCI HAR Dataset/")
write.table(independant.data, file = "independantTidyData.csv", quote=TRUE, sep =",", row.names=FALSE, col.names=TRUE)
setwd("../..")


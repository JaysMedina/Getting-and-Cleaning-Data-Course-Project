# Made by Jayson Marcelo A. Medina

library(dplyr)

# For reproducibility, it's best to download the zip file via code. Hence:

#### Zip download and opening ####

zipURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile = "HAR-Data.zip"

download.file(zipURL, zipFile, method = "curl")
filepath = "UCI HAR Dataset"
unzip(zipFile)

#### data reading ####

# load the labels for activities and features
activitylabels = read.table(file.path(filepath,"activity_labels.txt"), stringsAsFactors = FALSE ,sep = "")
colnames(activitylabels) = c("activityId","activityLabel")
features = read.table(file.path(filepath,"features.txt"), stringsAsFactors = FALSE ,sep = "") # will not convert text to factors

# read data for training
xtrain = read.table(file.path(filepath,"train","X_train.txt"),sep = "")
ytrain = read.table(file.path(filepath,"train","y_train.txt"),sep = "")
subjecttrain = read.table(file.path(filepath,"train","subject_train.txt"),sep = "")

# read data for testing
xtest = read.table(file.path(filepath,"test","X_test.txt"),sep = "")
ytest = read.table(file.path(filepath,"test","y_test.txt"),sep = "")
subjecttest = read.table(file.path(filepath,"test","subject_test.txt"),sep = "")

#### data merging step ####

# merge data
x_all = rbind(xtrain, xtest)
y_all = rbind(ytrain, ytest)
subject_all = rbind (subjecttrain, subjecttest)

# keep only relevant measurements (mean and standard dev)
select_features = grep("-(mean|std).*", as.character(features[,2]))
selectedColNames <- features[select_features, 2]
x_all = x_all[,select_features]

# assign column names
colnames(x_all) = selectedColNames
colnames(y_all) = "activity"
colnames(subject_all) = "subject"

# merge all
all = cbind(subject_all, y_all, x_all)

# change activities and subjects into factors
all$activity = factor(all$activity, levels = activitylabels[,1], labels = activitylabels[,2])
all$subject = as.factor(all$subject)

# create summary
all_mean <- all %>% group_by(activity, subject) %>% summarize_all(funs(mean))

# form the file

write.table(all_mean, file = "UCI-HAR-tidy-data.txt", row.names = FALSE, col.names = TRUE)

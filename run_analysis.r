#Load data.table and reshap2 2 packages

if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

require("data.table")
require("reshape2")

#Read activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

#Read data column names
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

#Extract means and standard deviations
extract_features <- grepl("mean|std", features)

#Read and process x_test & y_test data.
x_test <- read.table("./UCI HAR Dataset/test/x_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(x_test) = features

#Extract means and standard deviations
x_test = x_test[,extract_features]

#Read activity labels
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

#Bind data
test_data <- cbind(as.data.table(subject_test), y_test, x_test)

#Read and process x_train & y_train data.
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(X_train) = features

#Extract means and standard deviations
x_train = x_train[,extract_features]

#Read activity data
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

#Bind data
train_data <- cbind(as.data.table(subject_train), y_train, x_train)

#Merge test and train data
data = rbind(test_data, train_data)

id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data      = melt(data, id = id_labels, measure.vars = data_labels)

#Apply mean function to dataset
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)

write.table(tidy_data, file = "./tidy_data.txt")
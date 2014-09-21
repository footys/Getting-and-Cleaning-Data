
file <- 'UCI HAR Dataset.zip'
#check is file exists in working dir
if (!file.exists(file)){
    download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', destfile=file,method = "curl")
}

#read all nessesary data
train.data <- read.table(unz(file, 'UCI HAR Dataset/train/X_train.txt'))
test.data <- read.table(unz(file, 'UCI HAR Dataset/test/X_test.txt'))
train.labels <- read.table(unz(file, 'UCI HAR Dataset/train/y_train.txt'),col.names="label")
test.labels <- read.table(unz(file, 'UCI HAR Dataset/test/y_test.txt'),col.names="label")
train.subjects <- read.table(unz(file, 'UCI HAR Dataset/train/subject_train.txt'),col.names="subject")
test.subjects <- read.table(unz(file, 'UCI HAR Dataset/test/subject_test.txt'),col.names="subject")
features <- read.table(unz(file, "UCI HAR Dataset/features.txt"), strip.white=TRUE, stringsAsFactors=FALSE)
activities <- read.table(unz(file, "UCI HAR Dataset/activity_labels.txt"), stringsAsFactors=FALSE)

#step 1. Merge all data
data <- rbind(cbind(test.subjects, test.labels, test.data),
              cbind(train.subjects, train.labels, train.data))

#step 2.  Read the features with grep looking for mean and standart deviation and thatn select from data
features.mean.std <- features[grep("mean\\(\\)|std\\(\\)", features$V2), ]
data.mean.std <- data[, c(1, 2, features.mean.std$V1+2)]

# step 3. Reaplace activity labels
data.mean.std$label <- activities[data.mean.std$label, 2]

# step4.  first make a list of the current column names and feature names
good.colnames <- c("subject", "label", features.mean.std$V2)
# then tidy that list
# by removing every non-alphabetic character and converting to lowercase
good.colnames <- tolower(gsub("[^[:alpha:]]", "", good.colnames))
# then use the list as column names for data
colnames(data.mean.std) <- good.colnames

# step 5 find the mean for each combination of subject and activity labels
aggr.data <- aggregate(data.mean.std[, 3:ncol(data.mean.std)],
                       by=list(subject = data.mean.std$subject,
                               label = data.mean.std$label),
                       mean)

#step 6. Write tha data to course.
write.table(format(aggr.data, scientific=T), "tidy2.txt",
            row.names=F, col.names=F, quote=2)
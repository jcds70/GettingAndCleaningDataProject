### Assignment step #1
# load the train and test measurement files

x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")

subject_train <- read.table("train/subject_train.txt")
subject_test <- read.table("test/subject_test.txt")

# combine the data sets
x_combined <- rbind(x_train, x_test)
y_combined <- rbind(y_train, y_test)
subject_combined <- rbind(subject_train, subject_test)

### Assignment step #2
# extract only the mean and standard deviation of the measurements
# from the data set. Based on the description in features.txt, these are
# in these elements of the x_combined set:
# 1-6, 41-46, 81-86, 121-126, 161-166, 201-202, 214-215, 227-228,
# 240-241, 253-254, 266-271, 345-350, 424-429, 503-504, 516-517, 
# 529-530, 542-543

mean_std_cols <- c(1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215,
                   227:228, 240:241, 253:254, 266:271, 345:350, 424:429,
                   503:504, 516:517, 529:530, 542:543)
x_mean_std <- x_combined[ , mean_std_cols]

### Assignment step #3
# Create a factor that matches the activity labels provided in 
# activity_labels.txt
activity_labels_file <- read.table("activity_labels.txt")
activity_labels <- factor(activity_labels_file[,1], 
                          labels=activity_labels_file[,2])

# Create a new column of data based on the coded activity values in y_combined
activity_col <- activity_labels[y_combined[,1]]

# combine the subject data, the activity_col data, and the x_mean_std data set 
# into a data frame called "combined"
combined <- cbind(subject_combined, activity_col, x_mean_std)

### Assignment step #4
# label the combined data set with descriptive variable names derived from
# the features.txt file

# read in the features.txt file
features_file <- read.table("features.txt")
# create a vector of the names based on the mean_std_cols vector defined above
# this extracts the names only for the mean and standard deviation columns 
# extracted from the full data set above
data_col_names <- as.vector(features_file[mean_std_cols, 2])
# prepend a name for the activity column to the vector
comb_data_col_names <- c("Subject", "Activity", data_col_names)
# set the names on the "combined" data frame
names(combined) <- comb_data_col_names

#Also update the x_mean_std data frame column names for use in step #5
names(x_mean_std) <- data_col_names

### Assignment step #5
subject_col <- as.factor(subject_combined[[1]])
# use the aggregate function to take the average of the combined data set
# grouping records by the Subject and Activity columns
tidy_data <- aggregate(x_mean_std, list(Subject = subject_col, 
                         Activity = activity_col), mean)

# write the tidy data table to disk
write.table(tidy_data, "final_tidy_data.txt", row.names=FALSE)


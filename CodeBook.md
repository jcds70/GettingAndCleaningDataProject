This code book describes the data in the final_tidy_data.txt file and how the study data was transformed to produce it.

The x, y, and subject data from the train and test data sets were loaded and combined using rbind to append the rows together on each one.

The mean and standard deviation columns were selected to create a new data frame with only those variables of interest, and the Activity name and Subject ID were combined with it using cbind() to create a single combined data set.  Activity names were derived from the numeric codes by loading the activity_labels.txt file and creating a factor with the numeric code as the level and the activity name as the label, and using the activity name in the combined data set.

The data in the combined data set was then grouped by the Subject ID and Activity and the mean of all the other variables for each group was computed with the aggregate function and is output in the final_tidy_data.txt file.  Each row in the final data set represents the average of all the variables for one subject doing one activity.

Except for the first two columns Subject and Activity, the column variable names in final_tidy_data.txt are taken directly from the features.txt file and are described in features_info.txt.  The first two columns are derived from the subjects and activities data files and described here:

Subject - Unique ID number of each subject in the study

Activity - Has six possible values: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING



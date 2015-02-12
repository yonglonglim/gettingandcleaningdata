Getting and Cleaning Data Codebook
========================================================

The R script does the following:

1. Merges the training and test sets to create one dataset
2. It then reads the features.txt and extracts the measurements on the mean and standard deviation for each measurement.
3. After which, it reads the activity_labels.txt and uses descriptive activity names to name the activities in the dataset. Such as "walking", "walkingupstairs", "walkingdownstairs", "sitting", "standing" and "laying" 
4. Next, it labels the dataset with descriptive variable names, e.g. "tbodyacc-mean-x"
5. Lastly, it creates an independent tiny dataset with the average of each variable for each activity and each subject.

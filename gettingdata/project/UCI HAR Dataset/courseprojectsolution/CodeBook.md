The data and it's variable used stems from the UCI HAR Dataset:

The variables are:

tBodyAcc-XYZ :the body acceleration signals
tGravityAcc-XYZ :the gravity acceleration signals
tBodyAccJerk-XYZ :time-derived body linear acceleration signal 
tBodyGyroJerk-XYZ :time-derived body angular velocity signal
tBodyAccMag :magnitude of body acceleration in Euclidean norm
tGravityAccMag : magnitude of gravity acceleration in Euclidean norm
tBodyAccJerkMag : magnitude of time-derived body linear acceleration in Euclidean norm
tBodyGyroMag : magnitude of time-derived body angular acceleration in Euclidean norm
tBodyGyroJerkMag : magnitude of time-derived body linear acceleration in Euclidean norm
fBodyAcc-XYZ : FFT of body acceleration in Euclidean norm
fBodyAccJerk-XYZ :FFT of time-derived body linear acceleration in Euclidean norm
fBodyGyro-XYZ :FFT of angular velocity in Euclidean norm
fBodyAccJerkMag : FFT of magnitude of time-derived body angular acceleration in Euclidean norm
fBodyGyroMag : FFT of angular velocity in Euclidean norm magnitude
fBodyGyroJerkMag :FFT of angular acceleration in Euclidean norm magnitude
subject :The subject taking the test.
activity :What was the subject doing as data was taken. 

'-XYZ' indicates the X, Y and Z direction of the measurement.
All variable names but subject and activity have prefixes, relevant for our analysis are mean() and std(). These indicate the mean or standard deviation of the measurement and were selected from the main datasets described below.

The train data was taken from 'train/X_train.txt' the Training dataset, with subject data steming from train/subject_train.txt and the activity from train/y_train.txt. For the test dataset 'train' was replaced by 'test'.

In the processing, the datasets are merged and finally the averages of all variables are calculated by subject and descriptive activity. This cleaned dataset is returned as text file, the column/variable names are retained. More details can be found in the Readme file and the analysis script run_analysis.R. 

Getting and Cleaning Data Code Book
===================================

### Introduction

This is the code book for the project of Getting and Cleaning Data course. This
file describes variables used, the data used and the transformations performed
to get the tidy data.

### Variables Used

All the variables in this dataset other than `subject` and `activity` come from
`features.txt` from this [dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). Only the variables that contain `mean()`, `meanFreq()` and `std()` in their
name are chosen. The variable `subject` comes from `subject_[train/test].txt` file(s)
and the variable `activity` comes from `activity_labels.txt`.

### Naming Convention

*   All variable names begin with small case letters.
*   If the variables have two or more words, they are separated by a dot `.`
*   `mean` and `standardDeviation` always start with lower case letters, used camel
    case when a word follows `mean` or `standard` e.g. `meanFreq`
*   Used capitalized first letters and abbreviations for measurements,
    e.g. body is taken as `Body`, body acceleration as `BodyAcc`

#### Identifier measurements

*   `subject`: An integer between 1 and 30 assigned for each of the 30 volunteers
*   `activity`: The name of the activity performed.
    (Any one of the 6 activities: `STANDING, SITTING, LAYING, WALKING,`
                                    `WALKING_DOWNSTAIRS, WALKING_UPSTAIRS`)

***NOTE***: The combination of `subject` and `activity` makes up the identifier,
            i.e. `(1, STANDING), (1, SITTING), ..., (30, WALKING_DOWNSTAIRS), (30, WALKING_UPSTAIRS)`
            make up all the observations in the data. (Total `30*6` observations)

#### Time domain measurements of body, gravitational, and body jerk acceleration along each axis

````
time.BodyAcc.mean.X
time.BodyAcc.mean.Y
time.BodyAcc.mean.Z

time.BodyAcc.standardDeviation.X
time.BodyAcc.standardDeviation.Y
time.BodyAcc.standardDeviation.Z

time.GravityAcc.mean.X
time.GravityAcc.mean.Y
time.GravityAcc.mean.Z

time.GravityAcc.standardDeviation.X
time.GravityAcc.standardDeviation.Y
time.GravityAcc.standardDeviation.Z

time.BodyAccJerk.mean.X
time.BodyAccJerk.mean.Y
time.BodyAccJerk.mean.Z

time.BodyAccJerk.standardDeviation.X
time.BodyAccJerk.standardDeviation.Y
time.BodyAccJerk.standardDeviation.Z
````
#### Time domain measurements of body and body jerk orientation along each axis

````
time.BodyGyro.mean.X
time.BodyGyro.mean.Y
time.BodyGyro.mean.Z

time.BodyGyro.standardDeviation.X
time.BodyGyro.standardDeviation.Y
time.BodyGyro.standardDeviation.Z

time.BodyGyroJerk.mean.X
time.BodyGyroJerk.mean.Y
time.BodyGyroJerk.mean.Z

time.BodyGyroJerk.standardDeviation.X
time.BodyGyroJerk.standardDeviation.Y
time.BodyGyroJerk.standardDeviation.Z
````

#### Time domain measurements of magnitude of body, gravity, and body jerk acceleration 

````
time.BodyAccMag.mean
time.BodyAccMag.standardDeviation

time.GravityAccMag.mean
time.GravityAccMag.standardDeviation

time.BodyAccJerkMag.mean
time.BodyAccJerkMag.standardDeviation
````

#### Time domain measurements of  magnitude of body orientation and body jerk orientation

````
time.BodyGyroMag.mean
time.BodyGyroMag.standardDeviation

time.BodyGyroJerkMag.mean
time.BodyGyroJerkMag.standardDeviation
````

####  Frequency domain measurements of body, gravitational, and body jerk acceleration along each axis

````
frequency.BodyAcc.mean.X
frequency.BodyAcc.mean.Y
frequency.BodyAcc.mean.Z

frequency.BodyAcc.standardDeviation.X
frequency.BodyAcc.standardDeviation.Y
frequency.BodyAcc.standardDeviation.Z

frequency.BodyAcc.meanFrequency.X
frequency.BodyAcc.meanFrequency.Y
frequency.BodyAcc.meanFrequency.Z

frequency.BodyAccJerk.mean.X
frequency.BodyAccJerk.mean.Y
frequency.BodyAccJerk.mean.Z

frequency.BodyAccJerk.standardDeviation.X
frequency.BodyAccJerk.standardDeviation.Y
frequency.BodyAccJerk.standardDeviation.Z

frequency.BodyAccJerk.meanFrequency.X
frequency.BodyAccJerk.meanFrequency.Y
frequency.BodyAccJerk.meanFrequency.Z
````

####  Frequency domain measurements of body and body jerk orientation along each axis

````
frequency.BodyGyro.mean.X
frequency.BodyGyro.mean.Y
frequency.BodyGyro.mean.Z

frequency.BodyGyro.standardDeviation.X
frequency.BodyGyro.standardDeviation.Y
frequency.BodyGyro.standardDeviation.Z

frequency.BodyGyro.meanFrequency.X
frequency.BodyGyro.meanFrequency.Y
frequency.BodyGyro.meanFrequency.Z
````

####  Frequency domain measurements of magnitude of body, gravity, and body jerk acceleration 

````
frequency.BodyAccMag.mean
frequency.BodyAccMag.standardDeviation
frequency.BodyAccMag.meanFrequency

frequency.BodyBodyAccJerkMag.mean
frequency.BodyBodyAccJerkMag.standardDeviation
frequency.BodyBodyAccJerkMag.meanFrequency
````

####  Frequency domain measurements of  magnitude of body orientation and body jerk orientation

````
frequency.BodyBodyGyroMag.mean
frequency.BodyBodyGyroMag.standardDeviation
frequency.BodyBodyGyroMag.meanFrequency

frequency.BodyBodyGyroJerkMag.mean
frequency.BodyBodyGyroJerkMag.standardDeviation
frequency.BodyBodyGyroJerkMag.meanFrequency"
````

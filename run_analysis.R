# Load in packages
library(dplyr)

# Define the directory to test and train datasets
datasets <- c(test = "./Data/UCI HAR Dataset/test/",
              train = "./Data/UCI HAR Dataset/train/")


download_and_extract_data <- function() {
    # Check if Data directory exists. If it does not, create it
    if (!dir.exists("./Data")) {
        dir.create("Data")
    }

    # Check if Dataset.zip file exists or not. If it does not, download it.
    if (!file.exists("./Data/Dataset.zip")) {
        download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                      "./Data/Dataset.zip", method = "curl")
    }

    # Check if the content of Dataset.zip is extracted or not. If they are not,
    # unzip and extract them inside Data directory
    if (!dir.exists("./Data/UCI HAR Dataset")) {
        unzip("./Data/Dataset.zip", exdir = "./Data")
    }
}


get_column_names <- function() {
    # his function creates a dataframe with features of the data as entries
    df_names <- read.table("./Data/UCI HAR Dataset/features.txt",
                           col.names = c("index", "feature"))

    df_names[, "feature"]
}


get_activity_names <- function() {
    # This function gets all the activity names for the corresponding labels
    # Get activities from file
    activities <- read.table("./Data/UCI HAR Dataset/activity_labels.txt",
                           col.names = c("label", "activity"))

    # Create a list where label = activity
    activities_list <- list()

    for (i in 1:nrow(activities)) {
        activities_list[as.integer(activities[i, "label"])] = activities[i, "activity"]
    }

    activities_list
}


assign_names <- function(df) {
    # This function assigns the 561 feature names and 2 other column names
    # (i.e. "subject" and "activity") to the columns of df

    # Get column names
    df_names <- get_column_names()

    # Assign the names to the data frame
    names(df) <- c("subject", "activity", df_names)

    df
}


load_and_merge <- function() {
    # This function loads in data and binds it to create a single dataframe
    # Test data
    X_test <- read.table(paste0(datasets["test"], "X_test.txt"))
    y_test <- read.table(paste0(datasets["test"], "y_test.txt"))
    subject_test <- read.table(paste0(datasets["test"], "subject_test.txt"))

    # Train data
    X_train <- read.table(paste0(datasets["train"], "X_train.txt"))
    y_train <- read.table(paste0(datasets["train"], "y_train.txt"))
    subject_train <- read.table(paste0(datasets["train"], "subject_train.txt"))

    # Create test and train data frames
    test <- bind_cols(subject_test, y_test, X_test)
    train <- bind_cols(subject_train, y_train, X_train)

    # Assign names to test and train
    test <- assign_names(test)
    train <- assign_names(train)

    # Create the main data frame
    df <- bind_rows(train, test)

    df
}


get_mean_and_std <- function(df) {
    # Extract only the columns that have "mean" or "std" in their name
    df <- select(df, c("subject", "activity", contains("mean", ignore.case = FALSE) |
                     contains("std", ignore.case = FALSE)))
}


run_analysis <- function() {
    # Download and extract the content of the zip file if needed
    download_and_extract_data()

    # Create the merged data frame
    df <- load_and_merge()

    # Select only the relevant columns from df
    df <- get_mean_and_std(df)

    # Extract activities as a list where label = activity
    activities_list <- get_activity_names()

    # Modify the data frame to get the activity names for each label
    df <- df %>% mutate(activity = sapply(activity, function(x){activities_list[x]}))
    df$activity <- as.character(df$activity)

    # Tidy up the column names of the dataframe
    names(df) <- sub("^f", "frequency.", names(df))
    names(df) <- gsub("-", ".", names(df))
    names(df) <- sub("[(][)]", "", names(df))
    names(df) <- sub("^t", "time.", names(df))
    names(df) <- sub("std", "standardDeviation", names(df))

    # Group by subject and activity, then find out the average of all observations
    # that have the same subject and activity
    df <- df %>% group_by(subject, activity) %>% summarise(across(.fns = mean))

    # Convert tidy_df to dataframe
    df <- as.data.frame(df)

    df
}

tidy_df <- run_analysis()
tidy_df <- apply(tidy_df, 2, as.character)

# Save the tidy data in a file inside "Data" directory
write.table(tidy_df, "./tidy_data.csv", row.names = FALSE)

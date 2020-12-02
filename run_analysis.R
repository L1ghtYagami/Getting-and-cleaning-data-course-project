# Load in packages
library(dplyr)

# Load in config.R or directly define the variables
datasets <- c(test = "./Data/UCI HAR Dataset/test/",
              train = "./Data/UCI HAR Dataset/train/")


get_column_names <- function() {
    # Create a dataframe with column names as entries
    df_names <- read.table("./Data/UCI HAR Dataset/features.txt",
                           col.names = c("index", "feature"))

    df_names[, "feature"]
}


get_activity_names <- function() {
    # This function gets all the activity names for the corresponding labels
    activities <- read.table("./Data/UCI HAR Dataset/activity_labels.txt",
                           col.names = c("label", "activity"))

    activities_list <- list()

    for (i in 1:nrow(activities)) {
        activities_list[as.integer(activities[i, "label"])] = activities[i, "activity"]
    }

    activities_list
}


assign_names <- function(df) {
    # This function assigns the 561 feature names and 2 other column names
    # (i.e. "label" and "subject") to the columns of df

    # Get column names
    df_names <- get_column_names()

    # Assign the names to the data frame
    names(df) <- c("subject", "activity", df_names)

    df
}


load_and_merge <- function() {
    # Load in data and merge (i.e. bind to create a single dataframe)
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
    # Get column names
    df_names <- get_column_names()

    # Keep only the columns where mean() or std() is present
    df_names <- df_names[grepl("mean()|std()", df_names)]
    indices <- which(names(df) %in% df_names)

    df <- df[, c(1, 2, indices)]

    df
}


# Create the merged data frame
df <- load_and_merge()

# Select only the relevant columns from df
df <- get_mean_and_std(df)

# Extract activities as a list where label = activity
activities_list <- get_activity_names()

# Modify the data frame to get the activity names for each label
df <- df %>% mutate(activity = sapply(activity, function(x){activities_list[x]}))

# Tidy up the column names of the dataframe
#names(df) <- sub("^f", "frequency.", names(df))
#names(df) <- gsub("-", ".", names(df))
#names(df) <- sub("()$", "", names(df))
#names(df) <- sub("^t", "time.", names(df))



# Load in packages
library(dplyr)

# Load in config.R or directly define the variables
datasets <- c(test = "./Data/UCI HAR Dataset/test/",
              train = "./Data/UCI HAR Dataset/train/")


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

    # Create the main data frame
    df <- bind_rows(train, test)
    df
}

# Create the merged data frame
df <- load_and_merge()

# Create a dataframe with column names as entries
df_names <- read.table("./Data/UCI HAR Dataset/features.txt", col.names = c("index", "feature"))
df_names <- df_names[, "feature"]

# Assign the names to the data frame
names(df) <- c(df_names, "label", "subject")

# Keep only the columns where mean() or std() is present
df_names <- df_names[sapply(df_names, function(x){grepl("mean()|std()", x)})]
indices <- which(names(df) %in% df_names)

df <- df[, c(1, 2, indices)]


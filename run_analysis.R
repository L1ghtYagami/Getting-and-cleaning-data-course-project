# Load in packages
library(dplyr)

# Load in config.R or directly define the variables
datasets <- c(test = "./Data/UCI HAR Dataset/test/",
              train = "./Data/UCI HAR Dataset/train/")


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
test <- bind_cols(X_test, y_test, subject_test)
train <- bind_cols(X_train, y_train, subject_train)

# Create the main data frame
df <- bind_rows(train, test)


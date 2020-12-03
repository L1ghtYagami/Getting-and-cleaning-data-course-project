Getting-and-cleaning-data-course-project
========================================

## Introduction

This file explains the analysis performed by the `run_analysis.R` on the dataset obtained from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

## Steps to download data

This part is optional, as it is covered in the `run_analysis.R` file. But you can
do this part if you want to look at the directory structure of the dataset beforehand.

*   First create a directory and name it "Data"
*   Download and save the zip file of the data using this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
*   Extract the contents of the zip file inside "Data"

Now you are ready to run `run_analysis.R`

## The `run_analysis.R` file

There is the actual code inside the file `run_analysis.R` and some supporting functions.

### Packages
```
dplyr
```
### Functions

There are six functions that are used to load and tidy the data.

```
download_and_extract_data
get_column_names
get_activity_names
assign_names
load_and_merge
get_mean_and_std
run_analysis
```

#### Description

-   `download_and_extract_data()`

    This function does not take any input. It works in following steps

    1.  Checks if the "Data" directory exists in the main directory. If it does not,
        creates it.
    
    2.  Checks if dataset is downloaded or not. If it is not, downloads it.
    
    3.  Checks if the data is extracted from the zip file. If it is not, extracts
        it.

-   `get_column_names()`

    This function takes no input and returns a `character` vector of the names of
    the features obtained from `features.txt` file.
    
-   `get_activity_names()`

    This function does not take any input and returns a named `list` where the
    names are activity `labels` (from `1` to `6`) and the values are names of the
    `activity` (one of `STANDING, SITTING, LAYING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS`)
    obtained from `activity_labels.txt' file.
    
-   `assign_names(df)`

    This function takes as input the dataframe `df` and returns the dataframe `df`
    with changed column names. The new column names assigned to the dataframe are
    obtained with `get_column_names()` function.
    
-   `load_and_merge()`

    This function takes no input. It loads different dataframes from text files in
    "train" and "test" directories and binds them together using `bind_cols()` and 
    `bind_rows()` functions from `dplyr` package.
    
-   `get_mean_and_std(df)`

    This function takes a dataframe `df` as input and returns the dataframe with
    columns that have `mean` and `std` in them (strictly lowercase) along with 
    `subject` and `activity` columns.

-   `run_analysis()`

    This function is the main function that runs the analysis on the data, and
    returns the tidied dataframe. The steps it takes is as follows:
    
    1.  Creates the dataframe using `load_and_merge()` function
    
    2.  Selects only the relevant columns using `get_mean_and_std` function
    
    3.  Creates `activities_list` using `get_activity_names()` function
    
    4.  Replaces integers in `activity` column with their `activity_name` and
        Changes the class of `activity` from `list` to `character`.
    
    5.  Modifies the name of the columns to make them more readable.
    
    6.  For the observations that have the same `subject` and `activity` combination,
        calculates the `mean` of the columns using `group_by()` and `summarise()`
        functions
        
    7.  Converts the `tibble` created in step 6 into `data.frame`
    
    8.  Returns the tidied dataframe.

### Other variables

-   `datasets`
    
    A named characer vector, names are `test` and `train` and the values are the
    path to the `test` and `train` directories inside the "Data" directory.

-   `tidy_df`

    The tidy `data.frame` variable returned by `run_analysis()` function. This is
    then converted from `data.frame` to `matrix` to store it as a text file.

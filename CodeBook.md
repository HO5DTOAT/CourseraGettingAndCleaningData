# Getting and Cleaning Data Course Project

This file describes the data processing performed on the input data. All the operations are written in the script [run_analysis.R](run_analysis.R). Please see [README.md](README.md) for details about downloading the input data.

The contents of the data archive need to be extracted in a sub-directory under the current working directory of the R session. The script needs to be run from the current working directory.

The operations performed are as follows:
1. The *activity_labels.txt* file is read. This file contains the mapping between the activity number and its label. The values are stored in a data frame named **activity_labels**.
2. The names of the features are read from the file *features.txt* into the data frame **feature_names**. Any brackets and commas in the names are removed and dashes are replaced with an underscore. The entire name is converted to lowercase.
3. A list of the features that are needed in the final data set are stored in the data frame **required_features**. A regular expression is used to extract the column names from the list in the **feature_names** data frame.
4. The function **read_data** is used to combine the data from the *train* and *test* sub-directories into the data frame **merged_data**.
5. A new data frame **means_of_merged_data** containing the means of the variables per subject and activity is created from **merged_data**.
6. The column names of the variables of this data frame are prefixed with "mean_" to indicate that mean values are stored.
7. The contents of the data frame **means_of_merged_data** are written to a file named *final_data.txt* without column headers (this file is to be uploaded as part of the assignment submission).
8. All objects besides the data frames **merged_data** and **means_of_merged_data** are removed from memory.



## The function read_data
As the organization of files in the *test* and *train* directories is similar, a function **read_data** is defined to build a dataset from the three files in the directory. This function is passed the name of the sub-directory (*test* or *train*) and does the following:
1. Read the column vector of subject ids from the *subjects_\<sub-directory\>.txt*.
2. Read the column vector of activity ids from the file *y_\<sub-directory\>.txt* and replace the activity ids with the corresponding description from the **activity_labels** data frame.
3. Read the sensor data from the file *X_\<sub-directory\>.txt* using descriptions in **feature_names** as the column headings.
4. Use the contents of **required_features** to extract the columns that are required.
5. Combine the contents of the three data sets into a single data frame and return the result.
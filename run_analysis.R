# Read the activity labels
activity_labels <-
  read.delim(
    "data/activity_labels.txt",
    sep = " ",
    header = FALSE,
    col.names = c("activity_id", "activity_label")
  )

# Read the feature names
feature_names <-
  read.delim(
    "data/features.txt",
    sep = " ",
    header = FALSE,
    col.names = c("feature_id", "feature")
  )
feature_names[, "feature"] <-
  tolower(gsub("[()]", "", feature_names[, "feature"]))
feature_names[, "feature"] <-
  gsub("[-]", "_", feature_names[, "feature"])

# Build the list of column names (features) that are required from the data set.
# Use a regular expression to determine columns of means and std deviations.
# Here possible matches are _mean, _mean_x, _mean_y, _mean_z, _std, _std_x,
# _std_y, _std_z.
required_features <-
  grep("_mean([_xyz]{0,2})$|_std([_xyz]{0,2})$",
       feature_names$feature,
       value = TRUE)

# Function to read files in a folder and build the data frame with the
# required feature values.
read_data <- function(subfolder) {
  # 01. Read the subject data in the folder.
  subjects <-
    read.fwf(
      paste0("data/", subfolder, "/subject_", subfolder, ".txt"),
      widths = 2,
      col.names = c("subject")
    )
  
  # 02. Read activities and replace numeric values with corresponding labels.
  activities <-
    read.fwf(
      paste0("data/", subfolder, "/y_", subfolder, ".txt"),
      widths = 1,
      col.names = c("activity")
    )
  activities[, "activity"] <-
    activity_labels[as.numeric(activities$activity), "activity_label"]
  
  # 03. Read the sensor readings and select the required variables.
  readings <- read.fwf(
    paste0("data/", subfolder, "/X_", subfolder, ".txt"),
    widths =
      rep.int(16, length(feature_names[, "feature_id"])),
    sep = '',
    col.names = feature_names[, "feature"]
  )
  
  readings <- readings[, required_features]
  
  # 04. Combine the data sets into one and return the result.
  cbind(subjects, activities, readings)
}

# Create a combined data set using the training and test data.
merged_data <- rbind(read_data("train"), read_data("test"))

# Create a data set with average of each variables.
# 01. The values to be averaged are from column three onward.
#     The subject and activity are the grouping criteria.
means_of_merged_data <-
  aggregate(
    merged_data[, colnames(merged_data)[3:length(colnames(merged_data))]],
    by = list(merged_data$subject, merged_data$activity),
    FUN = mean
  )

# 02. Set the column names of the new data set.
#     For the calculated averages, prefix "mean_" to the column name.
colnames(means_of_merged_data)[1:2] <- c("subject", "activity")
colnames(means_of_merged_data)[3:length(colnames(means_of_merged_data))] <-
  sapply(
    colnames(means_of_merged_data)[3:length(colnames(means_of_merged_data))],
    FUN = function(name) {
      paste0("mean_", name)
    }
  )

# 03. Write the averages data set to file.
write.table(means_of_merged_data, file = "final_data.txt", row.names = FALSE)

# 04. Remove unwanted data.
rm(read_data,
   feature_names,
   activity_labels,
   required_features)

# Solution for Getting and Cleaning Data Course Project

This repository contains a solution for the week 4 graded assignment of the [Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning/home/info) course on Coursera.

The file [run_analysis.R](run_analysis.R) contains the script created to clean the input dataset and create a file with the new dataset as per instructions provided in the assignment. This script requires that the contents of the archive be placed in a data sub-directory under the current working directory of the R session. The script itself needs to be present in the current working directory, as shown below.
```
<current working directory of the R session>
 |-run_analysis.R
 |-data
 |  |-test
 |  |  |-...
 |  |-train
 |  |  |-...
 |  |-activity_labels.txt
 |  |-features.txt
 |  |-features_info.txt
 |  |-README.txt
```

The dataset can be downloaded from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). The description of the dataset is available [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The file [CodeBook.md](CodeBook.md) provides details about the operations performed on the data.

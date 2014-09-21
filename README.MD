# Getting and cleaning data

For creating a tidy data set of wearable computing data originally from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Files in this repo
* README.md -- you are reading it right now
* CodeBook.md -- codebook describing variables, the data and transformations
* run_analysis.R -- actual R code


## run_analysis.R walkthrough
It follows the goals step by step.

* Precondition: Script work with archived data to decrease disk space usage 
* Step 1:
  * Read all the test and training files.
  * Combine the files to a data frame in the form of subjects, labels, the rest of the data.

* Step 2:
  * A new data frame is then created that includes subjects, labels and the described features.

* Step 3:
  * Replace the numbers with the text for activity labels.

* Step 4:
  * Make a column list (includig "subjects" and "label" at the start)
  * Tidy-fy the list by removing all non-alphanumeric characters and converting the result to lowercase
  * Apply the now-good-columnnames to the data frame
  
* Step 5:
  * Create a new data frame by finding the mean for each combination of subject and label. It's done by `aggregate()` function
  
* Step 6:
  * Write the new tidy set into a text file called tidy2.txt, formatted similarly to the original files.
## run_analysis.R

library(plyr)


## 1. Merge the training and the test sets to create one data set.

        # Import the data sets 

        activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
        features <- read.table("./UCI HAR Dataset/features.txt")

        x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
        y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header = FALSE)
        subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header = FALSE)

        x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)
        y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header = FALSE)
        subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header = FALSE)        

        # Merge the training and test data sets 
        x <- rbind(x_train, x_test)
        y <- rbind(y_train, y_test)
        subject <- rbind(subject_train, subject_test)
        
        # Clean up some data frames that are no longer needed
        rm(x_train, y_train, subject_train, x_test, y_test, subject_test)
        
        # Name the columns of the data file using the features file
        names(x) <- features[,2]
        
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

        # Assemble a data farm
        
        df<-cbind.data.frame(subject, y , x[,1:6])

        
# 3. Uses descriptive activity names to name the activities in the data set
        
        # Replace numeric activities with more meaningful labels 
        
        df[,2] <- mapvalues(df[,2]
                , from = c("1", "2", "3", "4", "5", "6")
                , to = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")   )
                
        
# 4. Appropriately labels the data set with descriptive variable names. 
        
        # Give the data frame columns meaningful names

        names(df) <- c("Subject"
                        , "Activity"
                        , "MeanX"
                        , "MeanY"
                        , "MeanZ"
                        , "SDX"
                        , "SDY"
                        , "SDZ"
        )
        
        
        # Make the Subject and Activity columns factors
        
        df$Subject <- factor(df$Subject)
        df$Activity <- factor(df$Activity)
        
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

        df1 <-group_by(df, Subject, Activity)
        
        
        df2<- summarize(df1, meanx = mean(MeanX, na.rm = TRUE)
                        , meany = mean(MeanY, na.rm = TRUE)
                        , meanz = mean(MeanZ, na.rm = TRUE)
                        , sdx = mean(SDX, na.rm = TRUE)
                        , sdy = mean(SDY, na.rm = TRUE)
                        , sdz = mean(SDZ, na.rm = TRUE)
                  )

        # Give the columns their final column names
        #       (I tried giving the columns these names earlier, but found that I couldn't get
        #        the summarize command above to work with column name sthat contained spaces and
        #        commas)
        names(df2) <- c("Subject"
                       , "Activity"
                       , "Mean Body Acceleration, X axis"
                       , "Mean Body Acceleration, Y axis"
                       , "Mean Body Acceleration, Z axis"
                       , "Standard Deviation of Body Acceleration, X Axis"
                       , "Standard Deviation of Body Acceleration, Y Axis"
                       , "Standard Deviation of Body Acceleration, Z Axis"
        )
        
        
        # Write the tidy dataset to a file
        write.table(df2, file = "tidy_data.txt", row.names = FALSE)
        
        
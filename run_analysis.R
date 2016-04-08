#################################################################################
######STEP 1 MERGE THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET########
#################################################################################

## Assign the Test measurements from test/X_test.txt to a dataframe

DFTestRaw<-read.table("test/X_test.txt")

## Assign the test activity labels from test/y_test.txt to a dataframe

DFTestActivityLabel<-read.table("test/y_test.txt")

## Assign the test subjects to a dataframe

DFTestSubjects<-read.table("test/subject_test.txt")

## Cbind the Test Measurements & their Activity and Subject Data and store it into
## a dataframe

DFTestData<-cbind(DFTestRaw,DFTestActivityLabel,DFTestSubjects)


## Assign the Training measurements from train/X_train.txt to a dataframe

DFTrainRaw<-read.table("train/X_train.txt")

## Assign the training activity labels from train/y_train.txt to a dataframe

DFTrainActivityLabel<-read.table("train/y_train.txt")

## Assign the training subjects to a dataframe

DFTrainSubjects<-read.table("train/subject_train.txt")

## Cbind the Training Measurements & their Activity and Subject Data and store it
## into a dataframe

DFTrainData<-cbind(DFTrainRaw,DFTrainActivityLabel,DFTrainSubjects)

DFDataMerge<-rbind(DFTestData,DFTrainData)


###################################################################################
######STEP 2  EXTRACT ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION####
######FOR EACH MEASUREMENT.########################################################
###################################################################################


## Name the Activity label and Subject Columns

names(DFDataMerge)[562]<-"ActivityLabel"
names(DFDataMerge)[563]<-"Subject"

## Read the names of the measurements and store it in a dataframe

DFMeasurement<-read.table("features.txt",stringsAsFactors = FALSE)


## Name the Merged dataset column names with the measurement names

for(i in seq_along(DFMeasurement[[2]]))
{
  names(DFDataMerge)[i]<-DFMeasurement[[2]][i]
}

## Get the mean variable names from the dataframe and assign the character vector to a variable

MeanVar<-names(DFDataMerge)[grepl(pattern = "mean\\()",x = names(DFDataMerge),ignore.case = TRUE)]

## Get the standard deviation variable names from the dataframe and assign the character vector
## to a variable

StdDevVar<-names(DFDataMerge)[grepl(pattern = "std\\()",x = names(DFDataMerge),ignore.case = TRUE)]

## Keep only the mean and standard deviation measures in the dataframe

DFDataMerge<-DFDataMerge[,c(MeanVar,StdDevVar,"ActivityLabel","Subject")]

########################################################################################
#####STEP 3 USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET######
########################################################################################

## Read the activity information and assign to a dataframe
DFActivity<-read.table("activity_labels.txt",stringsAsFactors = FALSE)

## Name the activity dataset columns
names(DFActivity)<-c("ActivityLabel","ActivityName")

## Join the Measurement dataset with the activity dataset to get the activity name

DFDataMerge<-merge(x = DFDataMerge,y=DFActivity,by="ActivityLabel")

## Remove the actvity label (numeric) column
DFDataMerge<-DFDataMerge[,c(-1)]

#####################################################################################
######STEP 4 APPROPRIATELY LABEL THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES########
#####################################################################################

for(i in seq_along(names(DFDataMerge)))
{
  names(DFDataMerge)[i]<-gsub(pattern = "\\()",replacement = "",x=names(DFDataMerge)[i])
}


#########################################################################################
###STEP 5 CREATE A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE###
###FOR EACH ACTIVITY AND EACH SUBJECT.###################################################
#########################################################################################

## Aggregate all measure columns based on the actvity and the subject
DFTidyData<-aggregate(x=DFDataMerge[c(1:(length(names(DFDataMerge)) - 2))],by = list(DFDataMerge$ActivityName,DFDataMerge$Subject),FUN=mean)

## Rename the group columns with appropriate names

names(DFTidyData)[1:2]<-c("ActivityName","Subject")

## Sort the data

DFTidyData<-DFTidyData[order(DFTidyData[,1],DFTidyData[,2]),]


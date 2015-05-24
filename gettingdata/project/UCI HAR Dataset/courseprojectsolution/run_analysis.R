library(dplyr)
library(data.table)
############################################
#STEP 1: Reading the data, merging the two datasets, and labeling the columns 
#with descriptive variable names
############################################
names<-read.table("features.txt") #read column names

##TEST DATASET##
total1<-data.table(read.table(file.path("./test","X_test.txt"),col.names=names[,2])) #read test data
subj_dat1<-data.table(read.table(file.path("./test","subject_test.txt"),col.names="subject")) #read test data subjects
act_dat1<-data.table(read.table(file.path("./test","y_test.txt"),col.names="activity")) #read test data activities
add_dat1<-cbind(subj_dat1,act_dat1)  #merge activities and subjects of test data

##TRAIN DATASET##
total2<-data.table(read.table(file.path("./train","X_train.txt"),col.names=names[,2]))  # read train data
subj_dat2<-data.table(read.table(file.path("./train","subject_train.txt"),col.names="subject"))  # read train data subjects
act_dat2<-data.table(read.table(file.path("./train","y_train.txt"),col.names="activity")) # read train data activities
add_dat2<-cbind(subj_dat2,act_dat2)  # merge activities and subjects of train data
total<-rbind(total1, total2)  #merge train and test data
add_total<-rbind(data.table(add_dat1),data.table(add_dat2))  #merge train and test subject&activity data

###############################################
#STEP 2: Filter data to only select mean and std
###############################################
meantotal<-grep("mean()", names[,2],fixed=TRUE) # select mean columns
stdtotal<-grep("std()", names[,2],fixed=TRUE)  # select std columns
colstoselect<-sort(c(names[meantotal,2],names[stdtotal,2])) #all the columns to be selected
filtereddata<-total[,colstoselect, with=FALSE] # data of only the selected columns

##############################################
#STEP 3: Applies descriptive activity names
##############################################
acti_names<-c('WALKING', 'WALKING_UPSTAIRS', 'WALKING_DOWNSTAIRS', 'SITTING', 'STANDING', 'LAYING')
add_total[,activity:=acti_names[activity]] # map the activity numbers onto actual activity names
datawactivity<-cbind(filtereddata,add_total) #make a big data table with subject and activity names

################################################
#STEP 4: Create summary dataset
################################################
ssummarydata<-data.frame(matrix(ncol = 68, nrow = 180)) #empty data frame to store average data into
rr<-0 
for (i in acti_names) # loops over activities and creates subtable
  {
  act<-datawactivity[datawactivity$activity %in% i]
  for (j in 1:30) # loops over all subjecrs and creates sub-subtable
    {
    actsubj<-act[act$subject %in% c(toString(j))]
    setkey(actsubj, activity)
    rr<-rr+1
    ssummarydata[rr,] <- actsubj[, lapply(.SD,mean), by=activity] #calculates mean of sub-subtable
    }
  }
colnames(ssummarydata) <- c("activity", names(actsubj)[1:67]) #assigning column names to the columns
summarydata <- ssummarydata[,c(68, 1:67)] # swapping some columns so it looks prettier
summarydata <- summarydata[order(summarydata$subject) , ]
################################################
#STEP 5: Write summary table into text file
###############################################
write.table(summarydata,file="mytidy_summary.txt", row.names=FALSE, col.names=TRUE, sep="\t,", quote=FALSE)
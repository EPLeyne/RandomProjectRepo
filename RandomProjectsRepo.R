# From www.burns-stat.com/first-step-towards-r-spreadsheets/
# For the importing of .csv files into R

superbowl <- read.table(
  "http://www.portfolioprobe.com/R/blog/dowjones_super.csv", 
  sep=",", header=TRUE)  #seperator in .csv file is ",", file does have a header.
superbowl

head(superbowl)

plot(DowJonesSimpleReturn ~ Winner, superbowl)

plot(100*DowJonesSimpleReturn ~ Winner, superbowl, col="powderblue", ylab="Return (%)") #This reurns the plot 100x the y-axis, adds colour to the plot and gives the Yaxis a name

head (airquality)
tail (airquality)
Ct <- with(airquality, (Temp -32)/1.8) #This is changing the temp from F to C, but creates a seperate vector, not within the data frame
newAir <- within(airquality, Ctemp <- (Temp - 32)/1.8) #This also changes the temp from F to C but creats it within the exisiting Data Frame, now called newAir


head(newAir)




# When importing spreadsheets into R it is best to have no spaces in the words, eg. in 'airquality' data set, the second column is 'Solar.R', not 'Solar R'
# Additionally, make sure any comments that have been written into the spreadsheet is also deleted before importing.

# The command to import spreadsheets to Excel is df <- read.table("<FileName>.csv", 
# header = TRUE, sep=",") where df is the new file name, and you need to specify the extension (.txt or .csv, etc.). Seperator deafult is " " (space)

plot(Temp ~ Ctemp, newAir)
plot (Ozone ~ Month, newAir)
plot (Temp ~ Month, newAir)
plot (Solar.R ~ Ctemp, newAir)
plot (Ctemp ~ Day, newAir)
plot (newAir)
summary(newAir)




## From www.trendct.org/2015/06/12/r-for-beginners-how-to-transition-from-excel-to-r

teams <- c("Patriots","Red Sox","Celtics")
losses <- c(5,13,21)
away <- c(TRUE,FALSE,TRUE)

sports <- data.frame(teams,losses,away)


#Read in a .csv file and assign it to a variable

earnings <- read.csv("Employee_Earnings_Report_2014.csv", stringsAsFactors = FALSE)

#StringAsFactors=FALSE because we want to read the text as a string, not a factor
head (earnings)
tail (earnings)
str(earnings)

## As the '$' is a special character in R we have to strip out the sign from the data.
earnings$TOTAL.EARNINGS <- gsub("\\$","",earnings$TOTAL.EARNINGS)

## To change the format to numeric...
earnings$TOTAL.EARNINGS <- as.numeric(earnings$TOTAL.EARNINGS)

## To sort by colums TOTAL.EARNINGS descending....
earnings <- earnings[order(-earnings$TOTAL.EARNINGS),]


head(earnings)

## To create a new column with a formula (In this case, Total Earnings minus Overtime earning)
## First convert OVERTIME to numeric (as previous with TOTAL.EARNINGS column, if numeric already you can skip this step)...
earnings$OVERTIME <- gsub("\\$","", earnings$OVERTIME)
earnings$OVERTIME <- as.numeric(earnings$OVERTIME)
## Then create the column with the formula
earnings$Total.minus.OT <- earnings$TOTAL.EARNINGS - earnings$OVERTIME

## To filter a column create a subset...
fire_dept <- subset(earnings, DEPARTMENT.NAME=="Boston Fire Department")
head (fire_dept) 


## To make calculations on columns..
earnings_total <- sum (earnings$TOTAL.EARNINGS)
earnings_ave <- mean(earnings$TOTAL.EARNINGS)
earnings_median <- median(earnings$TOTAL.EARNINGS)


## To break up entries into multiple columns using the delimiter....
## In the Boston earnings data set we want to break up the NAME column into First.Name and Last.Name
## First make a new column of last name by deleteing everthing after the comma (",.*","" means take everthign after the comma and replace it with nothing)
earnings$Last.Name <- sub(",.*", "", earnings$NAME)
## Then make another column of the first names by deleting before the comma (".*,","" means replace everything before the comma with nothing)
earnings$First.Name <- sub(".*,", "", earnings$NAME)

#To create Middle name column based on First.Name column by deleting before space
#This makes an array out of the total number of observations in earnings
earnings_list <- 1:nrow(earnings)

#Making a loop to go through every line of the dataframe
for (i in earnings_list) {
  # Checks to see if there's a Space in each cell. 
  # If it does, value of Middle is whatever was after the space
  # If there is no space, that means there was no middle name, so it leaves it blank
  if (grepl(" ", earnings$First.Name[i])) {
    earnings$Middle[i] <- sub(".* ","", earnings$First.Name[i])
  } else {
    earnings$Middle[i] <- ""
  }
} #NOTE, there is a more efficient way to do it. I assure you. 
#Cleaning First.Name column by deleting after space
earnings$First.Name <- sub(" .*","",earnings$First.Name)


## To create a pivot table for a simpl count (in this case no. of employees per department)
## create a data frame to count the number of employees in each Department
Department_Workers <- data.frame(table(earnings$DEPARTMENT.NAME))
## Then sort it (+ or - before 'Department_Workers$Freq is ascending or descending)
Department_Workers <- Department_Workers[order(-Department_Workers$Freq),]
## Rename the columns
colnames(Department_Workers) <- c("Department", "Employees")


## Advanced Pivot table, in this case the income per Department, this will give a table of income per department
income <- tapply(earnings$TOTAL.EARNINGS, earnings$DEPARTMENT.NAME, sum)
## Make the table into a data frame
income <- data.frame(income)
## Create a column based on row names
income$Department <- rownames(income)
#Merge the column names with the Department workers count
merged <- merge(Department_Workers, income, by="Department")
## Sort it by income
merged <- merged[order(-merged$income),]


## Save the Data as a .csv file
write.csv(merged, "merged.csv")


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

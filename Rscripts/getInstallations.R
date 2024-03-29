# getInstallations.R

# myFilename <- 'c://Projects/commonData/Postcode data for small-scale installations 2017 - SGU-Solar.csv'
# myFilename <- 'c://Users/Paul/projects/common/Postcode data for small-scale installations 2017 - SGU-Solar.csv'
myFilename <- 'data/Postcode data for small-scale installations 2017 - SGU-Solar.csv'
myData <- fread(myFilename)
# str(myData)

myFilename <- "http://www.cleanenergyregulator.gov.au/DocumentAssets/Documents/Postcode%20data%20for%20small-scale%20installations%20-%20SGU-Solar.csv"
myData <- fread(
  myFilename
  # ,skip = 3
  )

# just keep the installations capacity in kw
myData <- cbind(
  postcode = myData$`Small Unit Installation Postcode`
  ,subset(myData, select = grep(pattern = 'kW', names(myData)))
)
# str(myData)

myClasses <- sapply(myData, class)
# table(myClasses)

for (col in names(myClasses)[myClasses == 'character'])
  set(
    myData
    , j = col
    , value = stripComma(myData[[col]])
  )

# melt to long
longData <- melt(
  myData
  , id.vars = 1
  , value.name = 'kW'
)
longData[, textString := substr(variable, 1, 8)]     # grab the date
longData[, capacity := cumsum(kW), by = .(postcode)] # running total
longData <- longData[ textString != 'SGU Rate']      # remove the total row
longData[, month := as.IDate(paste('01',textString), format = '%d %b %Y')]
longData <- longData[!is.na(month)]

# str(longData)
tables()

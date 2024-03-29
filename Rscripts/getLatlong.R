# getLatlong.R

# myFilename <- 'c://Users/Paul/projects/common/australian_postcodes.csv'
myFilename <- 'data/australian_postcodes.csv'
myData <- fread(
  file = myFilename
  , na.strings = 'NULL'
)
dim(myData)
head(myData, 20)

myData <- myData[type == 'Delivery Area']
dim(myData)
myData <- myData[complete.cases(myData[, .(lat, long)])]
dim(myData)
myData <- myData[ long > 100]
dim(myData)

pcData <- myData[
  , .(
    long = mean(long, na.rm = T)
    ,lat = mean(lat, na.rm = T)
    ,num = .N
    ,locale = paste(locality, collapse = ', ')
  )
  , by = .(postcode, state)
  ]
setorder(pcData, postcode, -num)
pcData <- pcData[, .SD[1], by = .(postcode)]

str(pcData)
tables()


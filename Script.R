# get XML package
install.packages('XML')
library(XML)

# generate a vector of urls
## input: rinNumber --- character vector with only one value
## output: a vector of urls; url leads to each separate page
generateUrl <- function(rinNumber) {
  fileUrl <- paste("http://www.reginfo.gov/public/do/eAgendaViewRule?RIN=", rinNumber, sep='')
  doc <- htmlTreeParse(fileUrl, useInternal= TRUE)
  rootNode <- xmlRoot(doc)
  urls <- xpathSApply(rootNode, "//a[@class='pageSubNavTxt']", xmlGetAttr, 'href')
  
  ### concat all relative urls with domain name to make url complete
  c = 1
  urls.length <- length(urls)
  while (c <= urls.length) {
    urls[c] = paste("http://www.reginfo.gov", urls[c], sep='')
    c = c + 1
  }
  
  urls
}

# generate a total data frame with the same RIN number
## input: urls -- character vector -- url of each separate page
## input: rinNumber --- character vector with only one value
## output: total data frame with the same RIN number
generateTotal <- function(urls, rinNumber) {
  ### prepare an empty data frame as total.byRIN
  total.byRIN <- data.frame(action=character(),
                            date=character(), 
                            stringsAsFactors=TRUE) 
    
  ### for every sep file, merge the mined data with total.byRIN
  for (i in urls) {
    sep.fileUrl <- i
    sep.doc <- htmlTreeParse(sep.fileUrl, useInternal= TRUE)
    sep.rootNode <- xmlRoot(sep.doc)
    action <- xpathSApply(sep.rootNode, "//td[@headers='action']", xmlValue)
    ### optimization
    if (length(action) == 0) {
      next
    }
    date <- xpathSApply(sep.rootNode, "//td[@headers='date']", xmlValue)
    sep.data <- data.frame(action, date)
    total.byRIN <- rbind(total.byRIN, sep.data) 
  }
  
  ### add RIN as a new column to total.byRIN
  total.byRIN$RIN <- rep.int(rinNumber, dim(total.byRIN)[1])
  
  ### return total.byRIN
  total.byRIN
}

# generate a total data frame with different RIN number
# for personal use
## input: two integers start and end; start is the starting point, end is the endpoint
## input: the range of start and end is between 1 and 43150
## output: a CSV file in the working directory 
## output: CSV file has structured data with action, date and RIN as the three columns
totalData <- function(start, end) {
  rin.total <- read.csv('1983-2013.csv', header = TRUE, colClasses = "character")
  rin.current <- rin.total[,1][start:end]
  
  ### prepare an empty data frame as total
  total <- data.frame(action=character(),
                      date=character(),
                      RIN = character(),
                      stringsAsFactors=TRUE)
  
  ### retrieve all relative urls of each rule under the same RIN
  for (i in rin.current) {
    rinNumber <- i
    urls <- generateUrl(rinNumber)
    ### optimization
    if (length(urls) == 0) {
      next
    } else {
      total <- rbind(total, generateTotal(urls, rinNumber))
    }
  }
  
  # output a csv file in working directory
  filename <- paste(as.character(start), as.character(end), sep="-")
  filename <- paste(filename, "csv", sep=".")
  write.csv(total, file = filename)
}

# application sample
totalData(1, 50)

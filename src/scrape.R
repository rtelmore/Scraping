## Ryan Elmore
## 25 Aug 2010
## Scraping with the XML library in R

## Basic template copied from:
##  http://industrialengineertools.blogspot.com/
##  Thanks Larry!

wd.path <- "~/Side_Projects/Sports/Scrape/"

years <- seq(2005, 2009, by = 1)

df.final <- data.frame()
for (i in 1:5){
  url.tmp <- paste("http://www.majorleaguesoccer.com/stats/", years[i], 
    sep = "")
  mls.url <- paste(url.tmp, "/reg", sep = "")
  print(mls.url)
  doc <- htmlTreeParse(mls.url, useInternalNodes=T)
  nset.stats <- getNodeSet(doc, 
    "//div/table[@class='stats sortable-first team-totals']")
  table.stats <- lapply(nset.stats, readHTMLTable, header = FALSE)
  nset.attendance <- getNodeSet(doc, 
    "//div/table[@class='sortable-first stats attendance']")
  table.attendance <- lapply(nset.attendance, readHTMLTable, header = FALSE)
  df.stats <- table.stats[[1]]
  df.attendance <- table.attendance[[1]]
  df.stats[order(df.stats$V1), ]
  df.attendance[order(df.attendance$V1), ]
  df.total <- merge(df.stats, df.attendance, by = "V1", all = TRUE)
  df.total$year <- rep(years[i], length(df.total$V1))  
  df.final <- rbind(df.final, df.total)
}

# source(paste(wd.path, "load.R", sep=""))

out.file <- paste(wd.path, "data/R_", 
              paste(format(Sys.Date(), "%Y%m%d"), ".csv", sep = ""), sep ="")
write.table(df.final, file = out.file, sep = ";", col.names = FALSE)


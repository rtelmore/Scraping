## Ryan Elmore
## 25 Aug 2010
## MLS comparison code

## Copyright (c) 2010, under the Simplified BSD License.  
## For more information on FreeBSD see: 
##      http://www.opensource.org/licenses/bsd-license.php
## All rights reserved.                      

wd.path <- "~/Side_Projects/Sports/Scraping/"

## Dependencies:
source(paste(wd.path, "src/load.R", sep = ""))

  
r.scrape <- system.time(source(paste(wd.path, "src/scrape.R", sep = "")))
py.scrape <- system.time(
               system("python ~/Side_Projects/Sports/Scraping/src/scraper.py"))

type <- c(rep("python", 5), rep("R", 5))
timing <- rep(names(py.scrape), 2)

df.scrape <- data.frame(type = type, timing = timing, values = values)

p <- ggplot(data = df.scrape, aes(x = timing, y = as.numeric(values), 
                                  group = type, colour = type)) 

p + geom_line(lty = 2) + 
  geom_point(colour="grey60", size = 4) +
  geom_point(aes(colour = type)) +
  scale_x_discrete("timed category") +
  scale_y_continuous("time (in sec)", limits = c(0, 3)) +
  scale_colour_manual("language", values = c("forestgreen", "darkred"))

ggsave(file = paste(wd.path, "fig/time.png", sep = ""), hei = 7, wid = 7)

## Ryan Elmore
## 25 Aug 2010
## MLS comparison code

## Copyright (c) 2010, under the Simplified BSD License.  
## For more information on FreeBSD see: 
##      http://www.opensource.org/licenses/bsd-license.php
## All rights reserved.                      

## I don't even know what that means, but other repositories tend to
##  have something similar (if not exact -- Thanks Drew Conway)! 

wd.path <- "~/Side_Projects/Sports/Scraping/"

## Dependencies:
source(paste(wd.path, "src/load.R", sep = ""))

  
py.scrape <- system.time(
               system("python ~/Side_Projects/Sports/Scraping/src/scraper.py"))
r.scrape <- system.time(source(paste(wd.path, "src/scrape.R", sep = "")))

type <- c(rep("python", 5), rep("R", 5))
timing <- rep(names(py.scrape), 2)
values <- as.numeric(round(c(py.scrape, r.scrape), 4))

df.scrape <- data.frame(cbind(type, timing, values))

p <- ggplot(data = df.scrape, aes(x = timing, y = values, 
                                  group = type, colour = type)) 

p + geom_line(lty = 3) + 
  geom_point(colour="grey60", size = 4) +
  geom_point(aes(colour = type)) +
  scale_x_discrete("timed category") +
  scale_colour_manual("language", values = c("forestgreen", "darkred"))

  
ggplot(data = df.scrape, aes(x = timing, y = values, fill = color)) +
  geom_bar(position = "dodge") + 
  scale_colour_identity(labels=levels(df.scrape$type), grob="bar", name="color") 

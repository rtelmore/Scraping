## Ryan Elmore
## 25 Aug 2010
## MLS comparison code

## Copyright (c) 2010, under the Simplified BSD License.  
## For more information on FreeBSD see: 
##      http://www.opensource.org/licenses/bsd-license.php
## All rights reserved.                      

## I don't even know what that means, but other repositories tend to
##  have something similar (if not exact -- Thanks Drew Conway)! 

wd.path <- "~/Side_Projects/Sports/Scrape/"

## Dependencies:
source(paste(wd.path, "src/load.R", sep = ""))

  
system.time(system("python scraper.py"))
system.time(source(paste(wd.path, "src/scrape.R", sep = "")))

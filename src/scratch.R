## Ryan Elmore
## 22 Aug 2010
## MLS scratch pad

## Copyright (c) 2010, under the Simplified BSD License.  
## For more information on FreeBSD see: 
##      http://www.opensource.org/licenses/bsd-license.php
## All rights reserved.                      

## I don't even know what that means, but other repositories tend to
##  have something similar (if not exact -- Thanks Drew Conway)! 

ggplot(data = mls.reg.dat, aes(x = a_tot, y = sog)) + geom_point() + 
  facet_wrap(~ team)

ggplot(data = mls.reg.dat, aes(x = year, y = shots)) + 
  geom_point(col="navy") + geom_smooth()


ggplot(data = mls.reg.dat, aes(x = year, y = sog)) + 
  geom_point(col="navy")

ggplot(data = mls.reg.dat, aes(x = year, y = sog/shots)) + 
  geom_point(col="navy") + geom_smooth()

ggplot(data = mls.reg.dat, aes(x = year, y = sog/shots, col = shots)) + 
  geom_point() + geom_smooth() + facet_wrap(~ team)

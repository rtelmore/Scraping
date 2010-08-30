#!/usr/bin/python

## Ryan Elmore
## 25 Aug 2010
## Scraping the Major League Soccer Site

## Copyright (c) 2010, under the Simplified BSD License.  
## For more information on FreeBSD see: 
##      http://www.opensource.org/licenses/bsd-license.php
## All rights reserved.                      

## I don't even know what that means, but other repositories tend to
##  have something similar (if not exact -- Thanks Drew Conway)! 

import urllib
import urllib2

from BeautifulSoup import BeautifulSoup
import re

from datetime import date, datetime
import time

import numpy

def get_mls_soup(year):
    url = "http://www.majorleaguesoccer.com/stats/%s/reg" % year
    # url = "file:///Users/relmore/Side_Projects/Sports/MLS/html/reg_%s.html"% year
    request = urllib2.Request(url)
    response = urllib2.urlopen(request)
    the_page = response.read()
    soup = BeautifulSoup(the_page)
    return soup
  

def process_mls_soup(soup):
    statistics_table = soup.find('table', \
        {"class":"stats sortable-first team-totals"})
    team_data = {}
    for row in statistics_table.findAll("tr"):
        col = row.findAll("td")
        if col:
            team = col[0].string.strip()
            stats = [item.string.strip() for item in col[1:]]
            team_data.update({team:stats})

    attendance_table = soup.find('table', \
        {"class":"sortable-first stats attendance"})
    for row in attendance_table.findAll("tr"):
        col = row.findAll("td")
        if col:
            team = col[0].string.strip()
            attendance = [item.string.strip() for item in col[1:]]
            team_data[team] += attendance

    return team_data

if __name__ == '__main__':
    print time.ctime() + ' -- Starting'
    
    outfile = \
        '/Users/relmore/Side_Projects/Sports/Scraping/data/py_%s.csv' \
        % date.today().strftime('%Y%m%d')
    f = open(outfile,'a')
  
    out_list = []
    for year in xrange(2005, 2010):
        soup = get_mls_soup(year)
        data = process_mls_soup(soup)
        for team in data.keys():
            out_list.append('%s; %s; '%(team, year) + '; '.join(data[team]))
        print time.ctime() + ' -- Year: %s' % year

    f.write('\n'.join(out_list) + '\n')
    f.close()
    print time.ctime() + ' -- Finished :)'

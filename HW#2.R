# In-Class Prompt #2

# Installing packages
# Comment oackages out after uploading them
# install.packages("dplyr")
# install.packages("lubridate")


# Bringing packages into library
library(dplyr)
library(lubridate)


# Reading data
streamH <- read.csv("/cloud/project/activtiy02/stream_gauge.csv")
siteInfo <- read.csv("/cloud/project/activtiy02/site_info.csv")


# Prompt #1
# Joining streamH and siteInfo into a data frame called Floods

Floods <- full_join(streamH, # left table
                    siteInfo, # right table
                    by="siteID") # common identifier
head(Floods)


# Prompt #2
# Parsing the date for the Floods data frame
Floods$datetime <- ymd_hm(Floods$datetime, tz="America/New_York")


# Prompt #3
# What was the earliest date that each river reached the flood stage?
Earliest_Floods <- Floods %>% # data frame with pipe
  group_by(names) %>% # group data frame by unique names
  filter(gheight.ft >= major.ft) %>% # filtering for flood height 
  summarise(datetime = min(datetime)) # next summarize using min




# HW #2




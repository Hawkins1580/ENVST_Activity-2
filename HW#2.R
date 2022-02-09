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
  group_by(names) %>% # group data frame by names
  filter(gheight.ft >= flood.ft) %>% # filtering for flood height 
  summarise(earliest.datetime = min(datetime)) # next summarize using min



# Homework #2

# Part #1 - Mutate Function (saving output with assignment operator)
Floods_Mutated <- mutate(Floods,
                        stage_meters = gheight.ft * 0.3048, # new column with stage in meters
                        percent_flood = (gheight.ft / major.ft) * 100) # new column with stage in percent of flood height


# Example to show why we need assignment operator 
mutate(Floods,
       stage_meters = gheight.ft * 0.3048, # new column with stage in meters
       percent_flood = (gheight.ft / major.ft) * 100) # new column with stage in percent of flood height

# Ready to work with group on presentation

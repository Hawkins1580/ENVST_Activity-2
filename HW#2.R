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

# IN-CLASS PROMPTS
# Prompt #1
# Joining streamH and siteInfo into a data frame called Floods

Floods <- full_join(streamH, # left table
                    siteInfo, # right table
                    by="siteID") # common identifier
head(Floods)


# Prompt #2
# Parsing the date for the Floods data frame
Floods$dateF <- ymd_hm(Floods$datetime, tz="America/New_York")


# Prompt #3
# What was the earliest date that each river reached the flood stage?
Earliest_Floods <- Floods %>% # data frame with pipe
  group_by(names) %>% # group data frame by names
  filter(gheight.ft >= flood.ft) %>% # filtering for flood height 
  summarise(earliest.datetime = min(datetime)) # next summarize using min



# HOMEWORK #2

# Part #1 - Mutate Function (saving output with assignment operator)
Floods_Mutated <- mutate(Floods,
                        stage_meters = gheight.ft * 0.3048, # new column with stage in meters
                        percent_flood = (gheight.ft / major.ft) * 100) # new column with stage in percent of flood height


# Example to show why we need assignment operator 
mutate(Floods,
       stage_meters = gheight.ft * 0.3048, # new column with stage in meters
       percent_flood = (gheight.ft / major.ft) * 100) # new column with stage in percent of flood height

# Ready to work with group on presentation

# Part #2

# Question #1 - Make a separate plot of the stream stage data for each river

# Fisheating Creek Plot
Fisheating_Creek <- Floods[Floods$names == "FISHEATING CREEK AT PALMDALE",]
plot(Fisheating_Creek$datetime, Fisheating_Creek$gheight.ft, type="l", xlab="Date",
     ylab = "Stage Height (ft)")

# Peace River Plot
Peace_River <- Floods[Floods$names == "PEACE RIVER AT US 17 AT ZOLFO SPRINGS",]
plot(Peace_River$datetime, Peace_River$gheight.ft, type="l", xlab="Date",
     ylab = "Stage Height (ft)")

# Santa Fe Plot
Santa_Fe <- Floods["SANTA FE RIVER NEAR FORT WHITE",]
plot(Santa_Fe$datetime, Santa_Fe$gheight.ft, type="l", xlab="Date",
     ylab = "Stage Height (ft)")

# Withlachoochee River Plot
Withlacoochee <- Floods["WITHLACOOCHEE RIVER AT US 301 AT TRILBY",]
plot(Withlacoochee$datetime, Withlacoochee$gheight.ft, type="b", xlab="Date",
     ylab = "Stage Height (ft)")






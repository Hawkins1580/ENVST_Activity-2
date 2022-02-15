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
Floods$datetime <- ymd_hm(Floods$datetime, tz="America/New_York")


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
     ylab = "Stage Height (ft)", main = "Fisheating River Stage Height", col = "cadetblue3", lwd = 6.0, ylim=c(4,12))

# Peace River Plot
Peace_River <- Floods[Floods$names == "PEACE RIVER AT US 17 AT ZOLFO SPRINGS",]
plot(Peace_River$datetime, Peace_River$gheight.ft, type="l", xlab="Date",
     ylab = "Stage Height (ft)", main = "Peace River Stage Height", col = "chartreuse3", lwd = 6.0, ylim=c(12,24))

# Santa Fe Plot
Santa_Fe <- Floods[Floods$names == "SANTA FE RIVER NEAR FORT WHITE",]
plot(Santa_Fe$datetime, Santa_Fe$gheight.ft, type="l", xlab="Date",
     ylab = "Stage height (ft)", main = "Santa Fe River Stage Height", col = "chocolate2", lwd = 6.0, ylim=c(0,15))

# Withlachoochee River Plot
Withlacoochee_River <- Floods[6474:8681,]
plot(Withlacoochee_River$datetime, Withlacoochee_River$gheight.ft, type="l", xlab="Date",
     ylab = "Stage Height (ft)", main = "Withlacoochee River Stage Height", col = "bisque3", lwd = 6.0, ylim=c(10,18))





# Question 2 - What was the earliest date of occurrence for each flood category in each river? 
# How quickly did changes in flood category occur for each river? 
# Do you think there was enough time for advanced warning before a flood category changed?

# Finding earliest action for each river
Action.Occurrence_Q2 <- Floods %>% # data frame with pipe
  group_by(names) %>% # group data frame by names
  filter(gheight.ft >= action.ft) %>% # filtering for action height 
  summarise(EarliestAction.DateTime = min(datetime)) # next summarize using min

# Finding earliest flood for each river
Flood.Occurrence_Q2 <- Floods %>% # data frame with pipe
  group_by(names) %>% # group data frame by names
  filter(gheight.ft >= flood.ft) %>% # filtering for flood height 
  summarise(EarliestAction.DateTime = min(datetime)) # next summarize using min

# Finding earliest moderate flood for each river
Moderate.Occurrence_Q2 <- Floods %>% # data frame with pipe
  group_by(names) %>% # group data frame by names
  filter(gheight.ft >= moderate.ft) %>% # filtering for moderate flood height 
  summarise(EarliestAction.DateTime = min(datetime)) # next summarize using min

# Finding earliest major flood for each river
Major.Occurrence_Q2 <- Floods %>% # data frame with pipe
  group_by(names) %>% # group data frame by names
  filter(gheight.ft >= major.ft) %>% # filtering for moderate flood height 
  summarise(EarliestAction.DateTime = min(datetime)) # next summarize using min



# Question 3 - Which river had the highest stream stage exceedance of its major flood category?

FloodsData_Q3 <- Floods %>% # data frame with pipe
  group_by(names) %>% # group data frame by names
  filter(gheight.ft >= major.ft) %>% # filtering for flood height 
  summarise(StreamStage.Major = max(gheight.ft)) # next summarize using min
  

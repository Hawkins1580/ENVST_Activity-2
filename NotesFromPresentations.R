# Notes from Presentations

# NOTES FROM PRESENTATIONS

# Presentation #1 - Select Function
# Used to select variables (columns)

VariableA <- select(Floods, names, gheight.ft, datetime)

# Using colon to select a range 
VariableB <- select(Floods, gheight.ft:datetime)

# Eliminating select columns
VariableC <- select(Floods, -datetime, -siteID)

# Contain eliminates the letter e from data
VariableE <- select(Floods, contains("e"), -agency)



# Presentation #2 - Histograms

Fisheating_Creek = Floods[1:208,]
hist(Fisheating_Creek$gheight.ft, main = "Fisheating Creek Water Height", xlab = "Water Hieght (ft)", col = "cyan", border = "black")

Santa_Fe_River <- Floods[4266:6473,]
hist(Santa_Fe_River$gheight.ft, main = "Santa Fe River",
     xlab = "Height (ft)",
     col = "tomato2",
     border = "blue")



# Presentation #3 - If Else Function
Floods$RiverLocation <- ifelse(Floods$names == 
                                 "Santa Fe River Near Fort White", TRUE, FALSE)
View(Floods)
#Load packages and modules
require("verification")
require("ggplot2")
####################
# set input files and output files
input_file1 = "/usr/people/wagenaa/Vlissingen/Information_level/48-120hr_vliss_IL/0809101112_48-120hr_vliss_IL.csv"
input_file2 = "/usr/people/wagenaa/Vlissingen/Information_level/48-120hr_vliss_IL/13141516_48-120hr_vliss_IL.csv"


#load csv data files
MyData1 <- read.csv(file=input_file1, header=TRUE, sep=",")
Events_obs = MyData1[ ,"event_obs"]
#print(Events_obs)
Predictions = MyData1[ ,"Pexc_brier"]
#print(Predictions)
MyData2 <- read.csv(file=input_file2, header=TRUE, sep=",")
Event_obs2 = MyData2[ , "event_obs"]
Predictions2 = MyData2[ , "Pexc_brier"]

#do statistics
verification = verify(Events_obs, Predictions)
verification2 = verify(Event_obs2, Predictions2)
print(verification)
print(verification2)

#make plot
pdf("/usr/people/wagenaa/Vlissingen/Attribute_diagrams/Vlissingen/Information_level/IL_48-120hr.pdf")
attribute(verification, main = "Attribute diagram, information level, 48-120hr lead time at Vlissingen", freq = FALSE)
lines.attrib(verification2, col = "green", lwd = 2, type = "b")
leg.txt = c("2008-2012", "2013-2016")
legend(0.74, 0.15, leg.txt, col = c("red", "green"), lwd = 2)
dev.off()

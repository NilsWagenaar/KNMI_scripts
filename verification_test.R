require("verification")
input_file5 = "/usr/people/wagenaa/Huibertgat/PreWarning/120-240hr/0809101112_120-240hr_Huibertgat_PW.csv"
input_file6 = "/usr/people/wagenaa/Huibertgat/PreWarning/120-240hr/13141516_120-240hr_Huibertgat_PW.csv"


#load csv data files
MyData5 <- read.csv(file=input_file5, header=TRUE, sep=",")
Events_obs5 = MyData5[ ,"event_obs"]
#print(Events_obs5)
Predictions5 = MyData5[ ,"Pexc_brier"]
#print(Predictions)
MyData6 <- read.csv(file=input_file6, header=TRUE, sep=",")
Event_obs6 = MyData6[ , "event_obs"]
Predictions6 = MyData6[ , "Pexc_brier"]

#do statistics
verification5 = verify(Events_obs5, Predictions5)
verification6 = verify(Event_obs6, Predictions6)
print(verification5)
#print(verification6$BS)


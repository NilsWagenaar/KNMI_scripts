require("ggplot2")
require("verification")

df = read.csv(file="/usr/people/wagenaa/6hrLead_Vliss_IL/6h_lead_informationlvl_vliss.csv", header=TRUE, sep=",")
df = na.omit(df)
print(df)
Obs = df[["event_occurrence"]]
Obs = as.numeric(as.character(Obs))
Sim = df[["Pexc"]]
#print(Sim)
Simvector <- as.vector(df['Pexc'])

class(Obs)
class(Sim)
a = brier(Obs, Sim, bins = FALSE)
#print(help(brier))
#b = verify(Obs, Sim)
print(a)
#print(b)	

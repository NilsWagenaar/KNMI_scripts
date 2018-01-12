
#Load packages and modules
require("verification")
require("ggplot2")
require("ROCR")

####################

# set input files and output files

#input_file1 = "/usr/people/wagenaa/Huibertgat/Seasons_-50surge/0-48hr/48hr_Huibertgat_-50surge_summer.csv"
#input_file2 = "/usr/people/wagenaa/Huibertgat/Seasons_-50surge/0-48hr/48hr_Huibertgat_-50surge_winter.csv"
#input_file3 = "/usr/people/wagenaa/Huibertgat/Seasons_-50surge/48-84hr/48-84hr_Huibertgat_-50surge_summer.csv"
#input_file4 = "/usr/people/wagenaa/Huibertgat/Seasons_-50surge/48-84hr/48-84hr_Huibertgat_-50surge_winter.csv"
#input_file5 = "/usr/people/wagenaa/Huibertgat/Seasons_-50surge/84-120hr/84-120hr_Huibertgat_-50surge_summer.csv"
#input_file6 = "/usr/people/wagenaa/Huibertgat/Seasons_-50surge/84-120hr/84-120hr_Huibertgat_-50surge_winter.csv"
#input_file7 = "/usr/people/wagenaa/Huibertgat/Seasons_-50surge/120-240hr/120-240hr_Huibertgat_-50surge_summer.csv"
#input_file8 = "/usr/people/wagenaa/Huibertgat/Seasons_-50surge/120-240hr/120-240hr_Huibertgat_-50surge_winter.csv"



#input_file1 = "/usr/people/wagenaa/test2/summer/06512/0-48/sum_06512_0-48_80.txt"
#input_file2 = "/usr/people/wagenaa/test2/winter/06512/0-48/sum_06512_0-48_80.txt"
#input_file3 = "/usr/people/wagenaa/test2/summer/06512/48-84/sum_06512_48-84_80.txt"
#input_file4 = "/usr/people/wagenaa/test2/winter/06512/48-84/sum_06512_48-84_80.txt"
#input_file5 = "/usr/people/wagenaa/test2/summer/06512/84-120/sum_06512_84-120_80.txt"
#input_file6 = "/usr/people/wagenaa/test2/winter/06512/84-120/sum_06512_84-120_80.txt"
#input_file7 = "/usr/people/wagenaa/test2/summer/06512/120-240/sum_06512_120-240_80.txt"
#input_file8 = "/usr/people/wagenaa/test2/winter/06512/120-240/sum_06512_120-240_80.txt"


input_file1 = "/usr/people/wagenaa/evaluation_ENS_1317/06514/0-48/sum_06514_0-48_200.txt"
input_file2 = "/usr/people/wagenaa/Cal_ENS_0912/06514/0-48/sum_06514_0-48_200.txt"
input_file3 = "/usr/people/wagenaa/Cal_ENS_0912_cor1317/06514/0-48/sum_06514_0-48_200.txt"
input_file4 = "/usr/people/wagenaa/evaluation_ENS_1317/06514/48-84/sum_06514_48-84_200.txt"
input_file5 = "/usr/people/wagenaa/Cal_ENS_0912/06514/48-84/sum_06514_48-84_200.txt"
input_file6 = "/usr/people/wagenaa/Cal_ENS_0912_cor1317/06514/48-84/sum_06514_48-84_200.txt"
input_file7 = "/usr/people/wagenaa/evaluation_ENS_1317/06514/84-120/sum_06514_84-120_200.txt"
input_file8 = "/usr/people/wagenaa/Cal_ENS_0912/06514/84-120/sum_06514_84-120_200.txt"
input_file9 = "/usr/people/wagenaa/Cal_ENS_0912_cor1317/06514/84-120/sum_06514_84-120_200.txt"
input_file10 = "/usr/people/wagenaa/evaluation_ENS_1317/06514/120-240/sum_06514_120-240_200.txt"
input_file11 = "/usr/people/wagenaa/Cal_ENS_0912/06514/120-240/sum_06514_120-240_200.txt"
input_file12 = "/usr/people/wagenaa/Cal_ENS_0912_cor1317/06514/120-240/sum_06514_120-240_200.txt"

output_file = "/usr/people/wagenaa/Hoek_van_Holland/ROC_diagrams/ROC_HVH__Validation_MS"



#load csv data files
MyData1 <- read.csv(input_file1, header=TRUE, sep=",")
Event_obs = MyData1[ ,"event_obs"]
Predictions = MyData1[ ,"Pexc_brier"]

MyData2 <- read.csv(file=input_file2, header=TRUE, sep=",")
Event_obs2 = MyData2[ , "event_obs"]
Predictions2 = MyData2[ , "Pexc_brier"]

MyData3<- read.csv(file=input_file3, header=TRUE, sep=",")
Event_obs3 = MyData3[ , "event_obs"]
Predictions3 = MyData3[ , "Pexc_brier"]

#do statistics
pred = prediction(Predictions, Event_obs)

#get false and true positive rate

roc.perf = performance(pred, measure = "tpr", x.measure = "fpr")

pred2 = prediction(Predictions2, Event_obs2)
roc.perf2 = performance(pred2, measure = "tpr", x.measure = "fpr")

pred3 = prediction(Predictions3, Event_obs3)
roc.perf3 = performance(pred3, measure = "tpr", x.measure = "fpr")

# retrieve Area Under the Curve

print(performance(pred, measure= 'auc'))
print(performance(pred2, measure = 'auc'))
print(performance(pred3, measure = 'auc'))

#make plot
pdf(output_file)

#split screen
par(mfrow = c(2,2))

#make plots

plot(roc.perf, main = "0-48hr", col = "red")
plot(roc.perf2, add =TRUE, col = "green")
plot(roc.perf3, add = TRUE, col = "blue")

#insert  1:1 line

abline(a=0, b= 1)

#legend

#leg.txt = c("2008-2012", "2013-2016")
#leg.txt = c("Lowtide", "Hightide")
#leg.txt = c("Summer", "Winter")
leg.txt = c("2003/04", "2013/14", "2015/16")
legend('bottomright', leg.txt, col = c("red", "green", "blue"), lwd = 0.5, cex = 0.75)

#Repetition

MyData4 <- read.csv(input_file4, header=TRUE, sep=",")
Event_obs4 = MyData4[ ,"event_obs"]
Predictions4 = MyData4[ ,"Pexc_brier"]
MyData5 <- read.csv(file=input_file5, header=TRUE, sep=",")
Event_obs5 = MyData5[ , "event_obs"]
Predictions5 = MyData5[ , "Pexc_brier"]
MyData6 = read.csv(file=input_file6, header=TRUE, sep=",")
Event_obs6 = MyData6[ , "event_obs"]
Predictions6 = MyData6[ , "Pexc_brier"]

pred4 = prediction(Predictions4, Event_obs4)
roc.perf4 = performance(pred4, measure = "tpr", x.measure = "fpr")
pred5 = prediction(Predictions5, Event_obs5)
roc.perf5 = performance(pred5, measure = "tpr", x.measure = "fpr")

print(performance(pred4, measure= 'auc'))

print(performance(pred5, measure = 'auc'))
pred6 = prediction(Predictions6, Event_obs6)
roc.perf6 = performance(pred6, measure = "tpr", x.measure = "fpr")
print(performance(pred6, measure= 'auc'))

plot(roc.perf4, main = "48-84hr", col = "red")
plot(roc.perf5, add =TRUE, col = "green")
plot(roc.perf6, add =TRUE, col = "blue")

abline(a=0, b= 1)
#leg.txt = c("2008-2012", "2013-2016")
#leg.txt = c("Lowtide", "Hightide")
#leg.txt = c("Summer", "Winter")
leg.txt = c("2003/04", "2013/14", "2015/16")

legend('bottomright', leg.txt, col = c("red", "green", "blue"), lwd = 0.5, cex = 0.75)



MyData7 <- read.csv(input_file7, header=TRUE, sep=",")
Event_obs7 = MyData7[ ,"event_obs"]
Predictions7 = MyData7[ ,"Pexc_brier"]
MyData8 <- read.csv(file=input_file8, header=TRUE, sep=",")
Event_obs8 = MyData8[ , "event_obs"]
Predictions8 = MyData8[ , "Pexc_brier"]
MyData8 <- read.csv(file=input_file8, header=TRUE, sep=",")
Event_obs8 = MyData8[ , "event_obs"]
Predictions8 = MyData8[ , "Pexc_brier"]
MyData9 <- read.csv(file=input_file9, header=TRUE, sep=",")
Event_obs9 = MyData9[ , "event_obs"]
Predictions9 = MyData9[ , "Pexc_brier"]


pred7 = prediction(Predictions7, Event_obs7)
roc.perf7 = performance(pred7, measure = "tpr", x.measure = "fpr")
print(roc.perf7)
pred8 = prediction(Predictions8, Event_obs8)
roc.perf8 = performance(pred8, measure = "tpr", x.measure = "fpr")
print("this is 2008-2012 and 84-120hr")
print(roc.perf8)
pred9 = prediction(Predictions9, Event_obs9)
roc.perf9 = performance(pred9, measure = "tpr", x.measure = "fpr")

print(performance(pred7, measure= 'auc'))
print(performance(pred8, measure = 'auc'))
print(performance(pred9, measure = 'auc'))

plot(roc.perf7, main = "84-120hr", col = "red")
plot(roc.perf8, add =TRUE, col = "green")
plot(roc.perf9, add =TRUE, col = "blue")
abline(a=0, b= 1)
#leg.txt = c("2008-2012", "2013-2016")
#leg.txt = c("Lowtide", "Hightide")
#leg.txt = c("Summer", "Winter")
leg.txt = c("2003/04", "2013/14", "2015/16") 
legend('bottomright', leg.txt, col = c("red", "green", "blue"), lwd = 0.5, cex = 0.75)



MyData10 <- read.csv(input_file10, header=TRUE, sep=",")
Event_obs10 = MyData10[ ,"event_obs"]
Predictions10 = MyData10[ ,"Pexc_brier"]
MyData11 <- read.csv(file=input_file11, header=TRUE, sep=",")
Event_obs11 = MyData11[ , "event_obs"]
Predictions11 = MyData11[ , "Pexc_brier"]
MyData12 <- read.csv(file=input_file12, header=TRUE, sep=",")
Event_obs12 = MyData12[ , "event_obs"]
Predictions12 = MyData12[ , "Pexc_brier"]



pred10 = prediction(Predictions10, Event_obs10)
roc.perf10 = performance(pred10, measure = "tpr", x.measure = "fpr")
print(roc.perf10)
pred11 = prediction(Predictions11, Event_obs11)
roc.perf11 = performance(pred11, measure = "tpr", x.measure = "fpr")
print("this is 2008-2012 and 120-240hr")
print(roc.perf11)
pred12 = prediction(Predictions12, Event_obs12)
roc.perf12 = performance(pred12, measure = "tpr", x.measure = "fpr")
print(roc.perf12)

print(performance(pred10, measure= 'auc'))
print(performance(pred11, measure = 'auc'))
print(performance(pred12, measure = 'auc'))


plot(roc.perf10, main = "120-240hr", col = "red")
plot(roc.perf11, add =TRUE, col = "green")
plot(roc.perf12, add =TRUE, col = "blue")
abline(a=0, b= 1)
#leg.txt = c("2008-2012", "2013-2016")
#leg.txt = c("Lowtide", "Hightide")
#leg.txt = c("Summer", "Winter")
leg.txt = c("2003/04", "2013/14", "2015/16")
legend('bottomright', leg.txt, col = c("red", "green", "blue"), lwd = 0.5, cex = 0.75)


#close the plot device
dev.off()


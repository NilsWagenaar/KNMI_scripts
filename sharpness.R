require("verification")
require("ggplot2")
require("gridExtra")
require(DataCombine)

#input files generated from another script

input_file3 = "/usr/people/wagenaa/Vlissingen/Information_level/0-48hr/0809101112_48hr_Vliss_IL.csv"
input_file4 = "/usr/people/wagenaa/Vlissingen/Information_level/0-48hr/13141516_48hr_Vliss_IL.csv"
input_file1 = "/usr/people/wagenaa/Vlissingen/Information_level/48-84hr/0809101112_48-84hr_Vliss_IL.csv"
input_file2 = "/usr/people/wagenaa/Vlissingen/Information_level/48-84hr/13141516_48-84hr_Vliss_IL.csv"
input_file5 = "/usr/people/wagenaa/Vlissingen/Information_level/84-120hr/0809101112_84-120hr_Vliss_IL.csv"
input_file6 = "/usr/people/wagenaa/Vlissingen/Information_level/84-120hr/13141516_84-120hr_Vliss_IL.csv"
input_file7 = "/usr/people/wagenaa/Vlissingen/Information_level/120-240hr/0809101112_120-240hr_Vliss_IL.csv"
input_file8 = "/usr/people/wagenaa/Vlissingen/Information_level/120-240hr/13141516_120-240hr_Vliss_IL.csv"


#load csv data files

MyData3 <- read.csv(file=input_file3, header=TRUE, sep=",")
Events_obs3 = MyData3[ ,"event_obs"]
#print(Events_obs)
Predictions3 = MyData3[ ,"Pexc_brier"]
#print(Predictions)
MyData4 <- read.csv(file=input_file4, header=TRUE, sep=",")
Event_obs4 = MyData4[ , "event_obs"]
Predictions4 = MyData4[ , "Pexc_brier"]
verification3 = verify(Events_obs3, Predictions3)
verification4 = verify(Event_obs4, Predictions4)

MyData1 <- read.csv(file=input_file1, header=TRUE, sep=",")
Events_obs = MyData1[ ,"event_obs"]
#print(Events_obs)
Predictions = MyData1[ ,"Pexc_brier"]
#print(Predictions)
MyData2 <- read.csv(file=input_file2, header=TRUE, sep=",")
Event_obs2 = MyData2[ , "event_obs"]
Predictions2 = MyData2[ , "Pexc_brier"]

# statistics

verification = verify(Events_obs, Predictions)
verification2 = verify(Event_obs2, Predictions2)

##################################

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

###################################################

#obtain thresholds

thresholds3= verification3$thres
id3 <- is.finite(Events_obs3) & is.finite(Predictions3)
obs3 <- Events_obs3[id3]
pred3 <- Predictions3[id3]
pred3 <- round(pred3, 8)
thresholds3<- round(thresholds3, 8 )

# bin probabilities

XX3<- probcont2disc(pred3, bins = thresholds3)
pred3 <- XX3$new
new.mids3<- XX3$mids

#obtain amount of predicitions and corresponding observations

N.pred3 <- aggregate(pred3, by = list(pred3), length)
N.obs3 <- aggregate(obs3, by = list(pred3), sum)

# generate an empty dataframe
XX3<- data.frame(Group.1 = new.mids3, zz = rep(0, length(thresholds3) -
            1))
XX3$Group.1 <- as.factor(XX3$Group.1)
N.pred3$Group.1 <- as.factor(N.pred3$Group.1)
N.obs3$Group.1 <- as.factor(N.obs3$Group.1)

# merge  N.pred and N.obs with empty dataframes

N.pred3 <- merge(XX3, N.pred3, all.x = TRUE)
N.obs3 <- merge(XX3, N.obs3, all.x = TRUE)

# repetition for other forecast period

thresholds4=verification4$thres
id4<- is.finite(Event_obs4) & is.finite(Predictions4)
obs4<- Event_obs4[id4]
pred4<- Predictions4[id4]
pred4<- round(pred4, 8)
thresholds4<-round(thresholds4, 8)
XX4<- probcont2disc(pred4, bins = thresholds4)
pred4 <- XX4$new
new.mids4<- XX4$mids
N.pred4 <- aggregate(pred4, by = list(pred4), length)
N.obs4 <- aggregate(obs4, by = list(pred4), sum)
XX4<- data.frame(Group.1 = new.mids4, zz = rep(0, length(thresholds4) -
1))

# make forecast period vectors

years = c(rep("2008-2012", 10))
years2 = c(rep("2013-2016", 10))

# trick to remove the period "string" whenever length N.pred dataframe is unequal to years vector 
if(length(years) != length(N.pred3[[1]])){
N = (abs((length(years) - length(N.pred3[[1]]))))
if (N>0){
n = 0
while (n != N){
years = years[-1]
n = n+1
}
}
#put the vector in the dataframe
N.pred3$years = years
} else{
N.pred3$years = years
}

if(length(years2) != length(N.pred4[[1]])){
N = (abs((length(years2) - length(N.pred4[[1]]))))
if (N>0){
n = 0
while (n != N){
years2 = years2[-1]
n = n+1
}
}
N.pred4$years = years2
} else{
N.pred4$years = years2
N.pred4$years = years2
}

#convert to log

N.pred3[, 3] = log(N.pred3[, 3], base = 10)
N.pred4[, 2] = log(N.pred4[, 2], base = 10)

# merge the dataframes

Dataframe1 <- merge(N.pred3, N.pred4, all = TRUE)

#remove the missing values

Dataframe1[is.na(Dataframe1)] = 0

print (Dataframe1)

#plot the dataframe

p1 <-ggplot(Dataframe1, aes(x = Group.1, y = x, fill = years))
p1 = p1 + geom_bar(stat = "identity", position = "dodge") + ggtitle("0-48hr") + theme(plot.title = element_text(size=16, face="bold.italic"))+theme(legend.text = element_text(size=10)) + xlab("probability forecast bins") + ylab("log # forecasts")


# repetitition


thresholds1= verification$thres
id1 <- is.finite(Events_obs) & is.finite(Predictions)
obs1 <- Events_obs[id1]
pred1 <- Predictions[id1]
pred1 <- round(pred1, 8)
thresholds1<- round(thresholds1, 8 )
XX1<- probcont2disc(pred1, bins = thresholds1)
pred1 <- XX1$new
new.mids1<- XX1$mids
N.pred1 <- aggregate(pred1, by = list(pred1), length)
N.obs1 <- aggregate(obs1, by = list(pred1), sum)
XX1<- data.frame(Group.1 = new.mids1, zz = rep(0, length(thresholds1) - 1))
XX1$Group.1 <- as.factor(XX1$Group.1)
N.pred1$Group.1 <- as.factor(N.pred1$Group.1)
N.obs1$Group.1 <- as.factor(N.obs1$Group.1)
N.pred1 <- merge(XX1, N.pred1, all.x = TRUE)
N.obs1 <- merge(XX1, N.obs1, all.x = TRUE)

thresholds2=verification2$thres
id2<- is.finite(Event_obs2) & is.finite(Predictions2)
obs2<- Event_obs2[id2]
pred2<- Predictions2[id2]
pred2<- round(pred2, 8)
thresholds2<-round(thresholds2, 8)
XX2<- probcont2disc(pred2, bins = thresholds2)
pred2 <- XX2$new
new.mids2<- XX2$mids
N.pred2 <- aggregate(pred2, by = list(pred2), length)
N.obs2 <- aggregate(obs2, by = list(pred2), sum)
XX2<- data.frame(Group.1 = new.mids2, zz = rep(0, length(thresholds2) -
1))
print (N.pred2)

years = c(rep("2008-2012", 10))
years2 = c(rep("2013-2016", 10))
if(length(years) != length(N.pred1[[1]])){
N = (abs((length(years) - length(N.pred1[[1]]))))

if (N>0){
n = 0
while (n != N){
years = years[-1]
n = n+1
}
}
N.pred1$years = years
} else{
N.pred1$years = years
}

if(length(years2) != length(N.pred2[[1]])){
N = (abs((length(years2) - length(N.pred2[[1]]))))
if (N>0){
n = 0
while (n != N){
years2 = years2[-1]
n = n+1
}
}
N.pred2$years = years2
} else{
N.pred2$years = years2
}
print("before log 2013")
#print(N.pred2)
#NewRow1 = c(as.numeric(0.55), 'NA', as.character("2013-2016"))
#NewRow2 = c(as.numeric(0.65), 'NA', as.character("2013-2016"))



#print(N.pred2)
N.pred1[, 3] = log(N.pred1[, 3], base = 10)
N.pred2[, 2] = log(N.pred2[, 2], base = 10)
#print(N.pred2)
#N.pred2 = InsertRow(N.pred2, NewRow = NewRow1, RowNum = 6)
#N.pred2 = InsertRow(N.pred2, NewRow = NewRow2, RowNum = 7)
#print (N.pred2)
#transform(N.pred2, x = as.numeric(x))
print (N.pred2)

Dataframe2 <- merge(N.pred2, N.pred1, all = TRUE)
#print (Dataframe2)
#Dataframe2 = InsertRow(Dataframe2, NewRow = NewRow1, RowNum = 11)
#Dataframe2 = InsertRow(Dataframe2, NewRow = NewRow2, RowNum = 12)
#print(Dataframe2)

Dataframe2[is.na(Dataframe2)] = 0
#is.num <- sapply(Dataframe2, is.numeric)
#Dataframe2[is.num] <- lapply(Dataframe2[is.num], round, 5)
apply(Dataframe2, 2, class)
#Dataframe2$x = Dataframe2$x <- as.numeric(as.character(Dataframe2$x))

#round(Dataframe2$x, 4)
print (Dataframe2)
#apply(Dataframe2, 2, class)

#Dataframe2 <- rbind(Dataframe2[,c(1,3,2)], cbind(expand.grid(A=levels(Dataframe2$years),C=levels(Dataframe2$x)), B=NA))

#spread(key = Dataframe2$years, value = Dataframe2$x, fill = NA) %>% # turn data to wide, using fill = NA to generate missing values
#gather(key = Dataframe2$years, value = Dataframe2$x, -(Dataframe2$Group.1)) %>% # go back to long, with the missings

p2 <-ggplot(Dataframe2, aes(x = Group.1, y = x, fill = years))
p2 = p2 + geom_bar(stat = "identity", position = "dodge") + ggtitle("48-84hr") + theme(plot.title = element_text(size=16, face="bold.italic"))+ theme(legend.text = element_text(size=10)) + xlab("probability forecast bins") + ylab("log # forecasts")



thresholds5= verification5$thres
id5 <- is.finite(Events_obs5) & is.finite(Predictions5)
obs5 <- Events_obs5[id5]
pred5 <- Predictions5[id5]
pred5 <- round(pred5, 8)
thresholds5<- round(thresholds5, 8 )
XX5<- probcont2disc(pred5, bins = thresholds5)
pred5 <- XX5$new
new.mids5<- XX5$mids
N.pred5 <- aggregate(pred5, by = list(pred5), length)
N.obs5 <- aggregate(obs5, by = list(pred5), sum)
XX5<- data.frame(Group.1 = new.mids5, zz = rep(0, length(thresholds5) - 1))
XX5$Group.1 <- as.factor(XX5$Group.1)
N.pred5$Group.1 <- as.factor(N.pred5$Group.1)
N.obs5$Group.1 <- as.factor(N.obs5$Group.1)
N.pred5 <- merge(XX5, N.pred5, all.x = TRUE)
N.obs5 <- merge(XX5, N.obs5, all.x = TRUE)

thresholds6=verification6$thres
id6<- is.finite(Event_obs6) & is.finite(Predictions6)
obs6<- Event_obs6[id6]
pred6<- Predictions6[id6]
pred6<- round(pred6, 8)
thresholds6<-round(thresholds6, 8)
XX6<- probcont2disc(pred6, bins = thresholds6)
pred6 <- XX6$new
new.mids6<- XX6$mids
N.pred6 <- aggregate(pred6, by = list(pred6), length)
N.obs6 <- aggregate(obs6, by = list(pred6), sum)
XX6<- data.frame(Group.1 = new.mids6, zz = rep(0, length(thresholds6) -
1))

years = c(rep("2008-2012", 10))
years2 = c(rep("2013-2016", 10))
if(length(years) != length(N.pred5[[1]])){
N = (abs((length(years) - length(N.pred5[[1]]))))

if (N>0){
n = 0
while (n != N){
years = years[-1]
n = n+1
}
}
N.pred5$years = years
} else{
N.pred5$years = years
}

if(length(years2) != length(N.pred6[[1]])){
N = (abs((length(years2) - length(N.pred6[[1]]))))
if (N>0){
n = 0
while (n != N){
years2 = years2[-1]
n = n+1
}
}
N.pred6$years = years2
} else{
N.pred6$years = years2
}

#NewRow3 = c(as.numeric(0.85), 'NA', as.character("2013-2016"))

N.pred5[, 3] = log(N.pred5[, 3], base = 10)
N.pred6[, 2] = log(N.pred6[, 2], base = 10)
#N.pred6 = InsertRow(N.pred6, NewRow = NewRow3, RowNum = 9)
print (N.pred6)
Dataframe3 <- merge(N.pred5, N.pred6, all = TRUE)
#Dataframe3$x = Dataframe3$x <- as.numeric(as.character(Dataframe3$x))
Dataframe3[is.na(Dataframe3)] = 0


p3 <-ggplot(Dataframe3, aes(x = Group.1, y = x, fill = years))
p3 = p3 + geom_bar(stat = "identity", position = "dodge") + ggtitle("84-120hr") + theme(plot.title = element_text(size=16, face="bold.italic")) + theme(legend.text = element_text(size=10))+ xlab("probability forecast bins") + ylab("log # forecasts")


MyData7 <- read.csv(file=input_file7, header=TRUE, sep=",")
Events_obs7 = MyData7[ ,"event_obs"]
print(Events_obs7)
Predictions7 = MyData7[ ,"Pexc_brier"]
print(Predictions7)
MyData8 <- read.csv(file=input_file8, header=TRUE, sep=",")
Event_obs8 = MyData8[ , "event_obs"]
Predictions8 = MyData8[ , "Pexc_brier"]

#do statistics
verification7 = verify(Events_obs7, Predictions7)
verification8 = verify(Event_obs8, Predictions8)

thresholds7= verification7$thres
id7 <- is.finite(Events_obs7) & is.finite(Predictions7)
obs7 <- Events_obs7[id7]
pred7 <- Predictions7[id7]
pred7 <- round(pred7, 8)
thresholds7<- round(thresholds7, 8 )
XX7<- probcont2disc(pred7, bins = thresholds7)
pred7 <- XX7$new
new.mids7<- XX7$mids
N.pred7 <- aggregate(pred7, by = list(pred7), length)
N.obs7 <- aggregate(obs7, by = list(pred7), sum)
XX7<- data.frame(Group.1 = new.mids7, zz = rep(0, length(thresholds7) - 1))
XX7$Group.1 <- as.factor(XX7$Group.1)
N.pred7$Group.1 <- as.factor(N.pred7$Group.1)
N.obs7$Group.1 <- as.factor(N.obs7$Group.1)
N.pred7 <- merge(XX7, N.pred7, all.x = TRUE)
N.obs7 <- merge(XX7, N.obs7, all.x = TRUE)

thresholds8=verification8$thres
id8<- is.finite(Event_obs8) & is.finite(Predictions8)
obs8<- Event_obs8[id8]
pred8<- Predictions8[id8]
pred8<- round(pred8, 8)
thresholds8<-round(thresholds8, 8)
XX8<- probcont2disc(pred8, bins = thresholds8)
pred8 <- XX8$new
new.mids8<- XX8$mids
N.pred8 <- aggregate(pred8, by = list(pred8), length)
N.obs8 <- aggregate(obs8, by = list(pred8), sum)
XX8<- data.frame(Group.1 = new.mids8, zz = rep(0, length(thresholds8) -
1))

years = c(rep("2008-2012", 10))
years2 = c(rep("2013-2016", 10))
if(length(years) != length(N.pred7[[1]])){
N = (abs((length(years) - length(N.pred7[[1]]))))

if (N>0){
n = 0
while (n != N){
years = years[-1]
n = n+1
}
}
N.pred7$years = years
} else{
N.pred7$years = years
}


if(length(years2) != length(N.pred8[[1]])){
N = (abs((length(years2) - length(N.pred8[[1]]))))
if (N>0){
n = 0
while (n != N){
years2 = years2[-1]
n = n+1
}
}
N.pred8$years = years2
} else{
N.pred8$years = years2
}

N.pred7[, 3] = log(N.pred7[, 3], base = 10)
N.pred8[, 2] = log(N.pred8[, 2], base = 10)
Dataframe4 <- merge(N.pred7, N.pred8, all = TRUE)

Dataframe4[is.na(Dataframe4)] = 0


p4 <-ggplot(Dataframe4, aes(x = Group.1, y = x, fill = years))

p4 = p4 + geom_bar(stat = "identity", position = "dodge") + ggtitle("120-240hr") + theme(plot.title = element_text(size=16, face="bold.italic")) + theme(legend.text = element_text(size=10))+ xlab("probability forecast bins") + ylab("log # forecasts")







grid_arrange_shared_legend <- function(...) {
    plots <- list(...)
    g <- ggplotGrob(plots[[1]] + theme(legend.position="bottom"))$grobs
    legend <- g[[which(sapply(g, function(x) x$name) == "guide-box")]]
    lheight <- sum(legend$height)
    grid.arrange(
        do.call(arrangeGrob, lapply(plots, function(x)
            x + theme(legend.position="none"))),
        legend,
        ncol = 1,
        heights = unit.c(unit(1, "npc") - lheight, lheight))
}



pdf("/usr/people/wagenaa/Vlissingen/Attribute_diagrams/Sharpness_Huibertgat_IL.pdf", onefile = FALSE)

grid_arrange_shared_legend(p1, p2, p3, p4)
#grid.arrange(p1, p2, p3, ncol=2)

dev.off()

#Load packages and modules
require("verification")
require("ggplot2")
require("gridExtra")
####################
# set input files and output files

input_file3 = "/usr/people/wagenaa/evaluation_ENS_1516/06514/0-48/sum_06514_0-48_200.txt"  
input_file4 = "/usr/people/wagenaa/calibration_ENS_1314_new/06514/0-48/sum_06514_0-48_200.txt"


#load csv data files
MyData3 <- read.csv(file=input_file3, header=TRUE, sep=",")
Events_obs3 = MyData3[ ,"event_obs"]
#print(Events_obs)
Predictions3 = MyData3[ ,"Pexc_brier"]
#print(Predictions)
MyData4 <- read.csv(file=input_file4, header=TRUE, sep=",")
Event_obs4 = MyData4[ , "event_obs"]
Predictions4 = MyData4[ , "Pexc_brier"]


#do statistics
verification3 = verify(Events_obs3, Predictions3, baseline =0.0022)
verification4 = verify(Event_obs4, Predictions4, baseline=0.0022)

#print some results
print(verification3)
print(verification4)

#print(verification4$bs)


#make plot
pdf("/usr/people/wagenaa/Hoek_van_Holland/Attribute_diagrams/1314calibration_HVH_PW.pdf", onefile=FALSE)
par(mfrow = c(2,2))

figure3 = attribute(verification3, main = "0-48hr", CI = TRUE, freq = FALSE)

n.boot = 1000
alpha = 0.05
obar.i_4 = verification4$obar.i
bins4 = verification4$bins
thres4 = verification4$thres
print(thres4)
print(Event_obs4[2])
n    <- length(Predictions4)
print(n)
OBAR4 <- matrix(NA, nrow = length(obar.i_4), ncol = n.boot)

for(i in 1:n.boot){
  ind4      <- sample(1:n, replace = TRUE)
  #print(is.numeric(Event_obs4[ind]))
  #print(is.numeric(Predictions4[ind]))
  YY	   <- verify(Event_obs4[ind4], Predictions4[ind4], show = FALSE, thresholds = thres4, bins = bins4)$obar.i
  OBAR4[,i] <- YY

} ## close 1:nboot

print (OBAR4)

a4<- apply(OBAR4,1, quantile, alpha, na.rm = TRUE)
b4<- apply(OBAR4,1, quantile, 1-alpha, na.rm = TRUE)




lines.attrib(verification4, col = "green", lwd = 2, type = "b")
tck = 0.01
for(i in 1:length(a4) ){
 lines(rep(verification4$y.i[i], 2), c(a4[i], b4[i] ), lwd = 1)
 lines( c(verification4$y.i[i] - tck, verification4$y.i[i] + tck), rep(a4[i],2), col = ("green"), lwd = 1 )
 lines( c(verification4$y.i[i] - tck, verification4$y.i[i] + tck), rep(b4[i],2), col = ("green"), lwd = 1 )
}


#leg.txt = c("2008-2012", "2013-2016")
leg.txt = c("2003/04-cal", "2013/14-cal")
#leg.txt = c("low-tide", "high-tide")
#leg.txt = c("summer", "winter")

legend(0.05, 0.95, leg.txt, col = c("red", "green"), lwd = 2, cex = 0.75)

input_file1 = "/usr/people/wagenaa/evaluation_ENS_1516/06514/48-84/sum_06514_48-84_200.txt" 
input_file2 = "/usr/people/wagenaa/calibration_ENS_1314_new/06514/48-84/sum_06514_48-84_200.txt"  


#load csv data files
MyData1 <- read.csv(file=input_file1, header=TRUE, sep=",")

Events_obs = MyData1[ ,"event_obs"]
#print(Events_obs)
Predictions = MyData1[ ,"Pexc_brier"]
#print(Predictions)
MyData2 <- read.csv(file=input_file2, header=TRUE, sep=",")
#textConnection(gsub("\t", ",", readLines("file.txt"))))
print(MyData2)
Event_obs2 = MyData2[ , "event_obs"]
Predictions2 = MyData2[ , "Pexc_brier"]

#do statistics
verification = verify(Events_obs, Predictions, baseline =0.0022)
verification2 = verify(Event_obs2, Predictions2, baseline = 0.0022)
#cat("lowtide -50cm surge is")
print(verification$bs)
#cat("hightide -50cm surge is")
print(verification2$bs)
#make plot

figure = attribute(verification, main = "48-84hr", CI = TRUE, freq = FALSE)

n.boot = 1000
alpha = 0.05
obar.i_2 = verification2$obar.i
bins2 = verification2$bins
thres2 = verification2$thres
print(thres2)
print(Event_obs2[2])
n    <- length(Predictions2)
print(n)
OBAR2 <- matrix(NA, nrow = length(obar.i_2), ncol = n.boot)

for(i in 1:n.boot){
  ind2      <- sample(1:n, replace = TRUE)
  #print(is.numeric(Event_obs2[ind]))
  #print(is.numeric(Predictions2[ind]))
  YY       <- verify(Event_obs2[ind2], Predictions2[ind2], show = FALSE, thresholds = thres2, bins = bins2)$obar.i    
  OBAR2[,i] <- YY
  
} ## close 1:nboot

print (OBAR2)

a2<- apply(OBAR2,1, quantile, alpha, na.rm = TRUE)
b2<- apply(OBAR2,1, quantile, 1-alpha, na.rm = TRUE)




lines.attrib(verification2, col = "green", lwd = 2, type = "b")
tck = 0.01
for(i in 1:length(a2) ){
 lines(rep(verification2$y.i[i], 2), c(a2[i], b2[i] ), lwd = 1)
 lines( c(verification2$y.i[i] - tck, verification2$y.i[i] + tck), rep(a2[i],2), col = "green", lwd = 1 )
 lines( c(verification2$y.i[i] - tck, verification2$y.i[i] + tck), rep(b2[i],2), col = "green", lwd = 1 )
}

#leg.txt = c("2008-2012", "2013-2016")
#leg.txt = c("low-tide", "high-tide")
#leg.txt = c("summer", "winter")
leg.txt = c("2003/04-cal", "2013/14-cal")

legend(0.05, 0.95, leg.txt, col = c("red", "green"), lwd = 2, cex = 0.75)
#grid.arrange(figure, figure, ncol=2)

#pdf("/usr/people/wagenaa/Den_Helder/Attribute_diagrams/Medium_surge/Medium_surge_48-120hr_13-16.pdf")
#attribute(verification2, main = "48-120hr", CI = TRUE, freq = FALSE, col = 3)
#leg.txt = c("2013-2016")
#legend(0.05, 0.95, leg.txt, col = c("green"), lwd = 2, cex = 0.75)

input_file5 = "/usr/people/wagenaa/evaluation_ENS_1516/06514/84-120/sum_06514_84-120_200.txt"
input_file6 = "/usr/people/wagenaa/calibration_ENS_1314_new/06514/84-120/sum_06514_84-120_200.txt"




#load csv data files
MyData5 <- read.csv(file=input_file5, header=TRUE, sep=",")
print(MyData5)
Events_obs5 = MyData5[ ,"event_obs"]
#print(Events_obs5)
Predictions5 = MyData5[ ,"Pexc_brier"]
#print(Predictions)
MyData6 <- read.csv(file=input_file6, header=TRUE, sep=",")
print(MyData6) 
Event_obs6 = MyData6[ , "event_obs"]
Predictions6 = MyData6[ , "Pexc_brier"]

#do statistics
verification5 = verify(Events_obs5, Predictions5, baseline =0.0022)
verification6 = verify(Event_obs6, Predictions6, baseline = 0.0022)
#print(verification5)
#print(verification6)
#make plot


figure5 = attribute(verification5, main = "84-120hr", CI = TRUE, freq = FALSE)

n.boot = 1000
alpha = 0.05
obar.i_6 = verification6$obar.i
bins6 = verification6$bins
thres6 = verification6$thres
#print(thres6)
#print(Event_obs6[2])
n    <- length(Predictions6)
#print(n)
OBAR6 <- matrix(NA, nrow = length(obar.i_6), ncol = n.boot)

for(i in 1:n.boot){
  ind6      <- sample(1:n, replace = TRUE)
  #print(is.numeric(Event_obs2[ind]))
  #print(is.numeric(Predictions2[ind]))
  YY       <- verify(Event_obs6[ind6], Predictions6[ind6], show = FALSE, thresholds = thres6, bins = bins6)$obar.i    
  OBAR6[,i] <- YY
  
} ## close 1:nboot

#print (OBAR6)

a6<- apply(OBAR6,1, quantile, alpha, na.rm = TRUE)
b6<- apply(OBAR6,1, quantile, 1-alpha, na.rm = TRUE)




lines.attrib(verification6, col = "green", lwd = 2, type = "b")
tck = 0.01
for(i in 1:length(a6) ){
 lines(rep(verification6$y.i[i], 2), c(a6[i], b6[i] ), lwd = 1)
 lines( c(verification6$y.i[i] - tck, verification6$y.i[i] + tck), rep(a6[i],2), col = "green", lwd = 1 )
 lines( c(verification6$y.i[i] - tck, verification6$y.i[i] + tck), rep(b6[i],2), col = "green", lwd = 1 )
}

#leg.txt = c("2008-2012", "2013-2016")
#leg.txt = c("low-tide", "high-tide")
#leg.txt = c("summer", "winter")
leg.txt = c("2003/2004-cal", "2013/14-cal")


legend(0.05, 0.95, leg.txt, col = c("red", "green"), lwd = 2, cex = 0.75)
#grid.arrange(figure, figure, ncol=2)

#pdf("/usr/people/wagenaa/Den_Helder/Attribute_diagrams/Medium_surge/Medium_surge_48-120hr_13-16.pdf")
#attribute(verification2, main = "48-120hr", CI = TRUE, freq = FALSE, col = 3)
#leg.txt = c("2013-2016")
#legend(0.05, 0.95, leg.txt, col = c("green"), lwd = 2, cex = 0.75)


input_file7 = "/usr/people/wagenaa/evaluation_ENS_1516/06514/120-240/sum_06514_120-240_200.txt"
input_file8 = "/usr/people/wagenaa/calibration_ENS_1314_new/06514/120-240/sum_06514_120-240_200.txt"




#load csv data files
MyData7 <- read.csv(file=input_file7, header=TRUE, sep=",")
Events_obs7 = MyData7[ ,"event_obs"]
#print(Events_obs7)
Predictions7 = MyData7[ ,"Pexc_brier"]
#print(Predictions)
MyData8 <- read.csv(file=input_file8, header=TRUE, sep=",")
Event_obs8 = MyData8[ , "event_obs"]
Predictions8 = MyData8[ , "Pexc_brier"]

#do statistics
verification7 = verify(Events_obs7, Predictions7, baseline=0.0022)
verification8 = verify(Event_obs8, Predictions8, baseline=0.0022)

print(verification7)
#print(verification8)
#make plot


figure7 = attribute(verification7, main = "120-240hr", CI = TRUE, freq = FALSE)

n.boot = 1000
alpha = 0.05
obar.i_8 = verification8$obar.i
bins8 = verification8$bins
thres8 = verification8$thres
#print(thres8)
#print(Event_obs8[2])
n    <- length(Predictions8)
#print(n)
OBAR8 <- matrix(NA, nrow = length(obar.i_8), ncol = n.boot)


for(i in 1:n.boot){
  ind8      <- sample(1:n, replace = TRUE)
  #print(is.numeric(Event_obs2[ind]))
  #print(is.numeric(Predictions2[ind]))
  YY	   <- verify(Event_obs8[ind8], Predictions8[ind8], show = FALSE, thresholds = thres8, bins = bins8)$obar.i
  OBAR8[,i] <- YY

} ## close 1:nboot

#print (OBAR6)

a8<- apply(OBAR8,1, quantile, alpha, na.rm = TRUE)
b8<- apply(OBAR8,1, quantile, 1-alpha, na.rm = TRUE)


lines.attrib(verification8, col = "green", lwd = 2, type = "b")
tck = 0.01
for(i in 1:length(a8) ){
 lines(rep(verification8$y.i[i], 2), c(a8[i], b8[i] ), lwd = 1)
 lines( c(verification8$y.i[i] - tck, verification8$y.i[i] + tck), rep(a8[i],2), col = "green", lwd = 1 )
 lines( c(verification8$y.i[i] - tck, verification8$y.i[i] + tck), rep(b8[i],2), col = "green", lwd = 1 )
}

#leg.txt = c("2008-2012", "2013-2016")
#leg.txt = c("low-tide", "high-tide")
#leg.txt = c("summer", "winter")
leg.txt = c("2003/2004-cal", "2013/2014-cal")


legend(0.05, 0.95, leg.txt, col = c("red", "green"), lwd = 2, cex = 0.75)


dev.off()


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


#pdf("/usr/people/wagenaa/Den_Helder/Attribute_diagrams/Medium_surge/RelFreqForecasts.pdf")
#pdf(file=pdf("/usr/people/wagenaa/Den_Helder/Attribute_diagrams/Medium_surge/RelFreqForecasts.pdf")
#par(mfrow = c(2,2))

#thresholds3= verification3$thres
#id3 <- is.finite(Events_obs3) & is.finite(Predictions3)
#obs3 <- Events_obs3[id3]
#pred3 <- Predictions3[id3]
#pred3 <- round(pred3, 8)
#thresholds3<- round(thresholds3, 8 )
#XX3<- probcont2disc(pred3, bins = thresholds3)
#pred3 <- XX3$new
#new.mids3<- XX3$mids
#N.pred3 <- aggregate(pred3, by = list(pred3), length)
#N.obs3 <- aggregate(obs3, by = list(pred3), sum)
#XX3<- data.frame(Group.1 = new.mids3, zz = rep(0, length(thresholds3) - 
            1))
#XX3$Group.1 <- as.factor(XX3$Group.1)
#N.pred3$Group.1 <- as.factor(N.pred3$Group.1)
#N.obs3$Group.1 <- as.factor(N.obs3$Group.1)
#N.pred3 <- merge(XX3, N.pred3, all.x = TRUE)
#N.obs3 <- merge(XX3, N.obs3, all.x = TRUE)

#thresholds4=verification4$thres
#id4<- is.finite(Event_obs4) & is.finite(Predictions4)
#obs4<- Event_obs4[id4]
#pred4<- Predictions4[id4]
#pred4<- round(pred4, 8)
#thresholds4<-round(thresholds4, 8)
#XX4<- probcont2disc(pred4, bins = thresholds4)
#pred4 <- XX4$new
#new.mids4<- XX4$mids
#N.pred4 <- aggregate(pred4, by = list(pred4), length)
#N.obs4 <- aggregate(obs4, by = list(pred4), sum)
#XX4<- data.frame(Group.1 = new.mids4, zz = rep(0, length(thresholds4) - 
#1))

#years = c(rep("2008-2012", 10))
#years2 = c(rep("2013-2016", 10))
#if(length(years) != length(N.pred3[[1]])){
#N = (abs((length(years) - length(N.pred3[[1]]))))

#if (N>0){
#n = 0
#while (n != N){
#years = years[-1]
#n = n+1
#} 
#}
#N.pred3$years = years
#} else{
#N.pred3$years = years
#}

#N.pred3 = N.pred3[complete.cases(N.pred3), ]

#RelFreq08 = N.pred3$x/sum(N.pred3$x)
#print

#N.pred3$Relative_freq = RelFreq08


#if(length(years2) != length(N.pred4[[1]])){
#N = (abs((length(years2) - length(N.pred4[[1]]))))
#if (N>0){
#n = 0
#while (n != N){
#years2 = years2[-1]
#n = n+1
#} 
#}
#N.pred4$years = years2
#} else{
#N.pred4$years = years2
#N.pred4$years = years2
#}
#N.pred4	= N.pred4[complete.cases(N.pred4), ]
#RelFreq16 = N.pred4$x/sum(N.pred4$x)

#N.pred4$Relative_freq = RelFreq16


          
#Dataframe1 <- merge(N.pred3, N.pred4, all = TRUE)

#p1 <-ggplot(Dataframe1, aes(x = Group.1, y = Relative_freq, fill = years))
#p1 = p1 + geom_bar(stat = "identity", position = "dodge") + ggtitle("0-48hr") + theme(plot.title = element_text(size=16, face="bold.italic"))+theme(legend.text = element_text(size=10)) + xlab("probability forecast bins") + ylab("count forecasts")


#thresholds1= verification$thres
#id1 <- is.finite(Events_obs) & is.finite(Predictions)
#obs1 <- Events_obs[id1]
#pred1 <- Predictions[id1]
#pred1 <- round(pred1, 8)
#thresholds1<- round(thresholds1, 8 )
#XX1<- probcont2disc(pred1, bins = thresholds1)
#pred1 <- XX1$new
#new.mids1<- XX1$mids
#N.pred1 <- aggregate(pred1, by = list(pred1), length)
#N.obs1 <- aggregate(obs1, by = list(pred1), sum)
#XX1<- data.frame(Group.1 = new.mids1, zz = rep(0, length(thresholds1) - 1))
#XX1$Group.1 <- as.factor(XX1$Group.1)
#N.pred1$Group.1 <- as.factor(N.pred1$Group.1)
#N.obs1$Group.1 <- as.factor(N.obs1$Group.1)
#N.pred1 <- merge(XX1, N.pred1, all.x = TRUE)
#N.obs1 <- merge(XX1, N.obs1, all.x = TRUE)

#thresholds2=verification2$thres
#id2<- is.finite(Event_obs2) & is.finite(Predictions2)
#obs2<- Event_obs2[id2]
#pred2<- Predictions2[id2]
#pred2<- round(pred2, 8)
#thresholds2<-round(thresholds2, 8)
#XX2<- probcont2disc(pred2, bins = thresholds2)
#pred2 <- XX2$new
#new.mids2<- XX2$mids
#N.pred2 <- aggregate(pred2, by = list(pred2), length)
#N.obs2 <- aggregate(obs2, by = list(pred2), sum)
#XX2<- data.frame(Group.1 = new.mids2, zz = rep(0, length(thresholds2) - 
#1))

#years = c(rep("2008-2012", 10))
#years2 = c(rep("2013-2016", 10))
#if(length(years) != length(N.pred1[[1]])){
#N = (abs((length(years) - length(N.pred1[[1]]))))

#if (N>0){
#n = 0
#while (n != N){
#years = years[-1]
#n = n+1
#} 
#}
#N.pred1$years = years
#} else{
#N.pred1$years = years
#}

#N.pred1	= N.pred1[complete.cases(N.pred1), ]

#RelFreq08 = N.pred1$x/sum(N.pred1$x)

#N.pred1$Relative_freq = RelFreq08


#if(length(years2) != length(N.pred2[[1]])){
#N = (abs((length(years2) - length(N.pred2[[1]]))))
#if (N>0){
#n = 0
#while (n != N){
#years2 = years2[-1]
#n = n+1
#} 
#}
#N.pred2$years = years2
#} else{
#N.pred2$years = years2
#}

#N.pred2	= N.pred2[complete.cases(N.pred2), ]

#RelFreq16 = N.pred2$x/sum(N.pred2$x)

#N.pred2$Relative_freq = RelFreq16

          
#Dataframe2 <- merge(N.pred1, N.pred2, all = TRUE)

#p2 <-ggplot(Dataframe2, aes(x = Group.1, y = Relative_freq, fill = years))
#p2 = p2 + geom_bar(stat = "identity", position = "dodge") + ggtitle("60-120hr") + theme(plot.title = element_text(size=16, face="bold.italic"))+ theme(legend.text = element_text(size=10)) + xlab("probability forecast bins") + ylab("count forecasts")



#thresholds5= verification5$thres
#id5 <- is.finite(Events_obs5) & is.finite(Predictions5)
#obs5 <- Events_obs5[id5]
#pred5 <- Predictions5[id5]
#pred5 <- round(pred5, 8)
#thresholds5<- round(thresholds5, 8 )
#XX5<- probcont2disc(pred5, bins = thresholds5)
#pred5 <- XX5$new
#new.mids5<- XX5$mids
#N.pred5 <- aggregate(pred5, by = list(pred5), length)
#N.obs5 <- aggregate(obs5, by = list(pred5), sum)
#XX5<- data.frame(Group.1 = new.mids5, zz = rep(0, length(thresholds5) - 1))
#XX5$Group.1 <- as.factor(XX5$Group.1)
#N.pred5$Group.1 <- as.factor(N.pred5$Group.1)
#N.obs5$Group.1 <- as.factor(N.obs5$Group.1)
#N.pred5 <- merge(XX5, N.pred5, all.x = TRUE)
#N.obs5 <- merge(XX5, N.obs5, all.x = TRUE)

#thresholds6=verification6$thres
#id6<- is.finite(Event_obs6) & is.finite(Predictions6)
#obs6<- Event_obs6[id6]
#pred6<- Predictions6[id6]
#pred6<- round(pred6, 8)
#thresholds6<-round(thresholds6, 8)
#XX6<- probcont2disc(pred6, bins = thresholds6)
#pred6 <- XX6$new
#new.mids6<- XX6$mids
#N.pred6 <- aggregate(pred6, by = list(pred6), length)
#N.obs6 <- aggregate(obs6, by = list(pred6), sum)
#XX6<- data.frame(Group.1 = new.mids6, zz = rep(0, length(thresholds6) - 
#1))

#years = c(rep("2008-2012", 10))
#years2 = c(rep("2013-2016", 10))
#if(length(years) != length(N.pred5[[1]])){
#N = (abs((length(years) - length(N.pred5[[1]]))))

#if (N>0){
#n = 0
#while (n != N){
#years = years[-1]
#n = n+1
#} 
#}
#N.pred5$years = years
#} else{
#N.pred5$years = years
#}

#N.pred5	= N.pred5[complete.cases(N.pred5), ]
#RelFreq12 = N.pred5$x/sum(N.pred5$x)

#N.pred5$Relative_freq = RelFreq12


#if(length(years2) != length(N.pred6[[1]])){
#N = (abs((length(years2) - length(N.pred6[[1]]))))
#if (N>0){
#n = 0
#while (n != N){
#years2 = years2[-1]
#n = n+1
#} 
#}
#N.pred6$years = years2
#} else{
#N.pred6$years = years2
#}

#N.pred6	= N.pred6[complete.cases(N.pred6), ]
#RelFreq16 = N.pred6$x/sum(N.pred6$x)

#N.pred6$Relative_freq = RelFreq16

          
#Dataframe3 <- merge(N.pred5, N.pred6, all = TRUE)

#p3 <-ggplot(Dataframe3, aes(x = Group.1, y = Relative_freq, fill = years))
#p3 = p3 + geom_bar(stat = "identity", position = "dodge") + ggtitle("120-240hr") + theme(plot.title = element_text(size=16, face="bold.italic")) + theme(legend.text = element_text(size=10))+ xlab("probability forecast bins") + ylab("count forecasts")


#pdf("/usr/people/wagenaa/Delfzijl/Attribute_diagrams/PreWarning/RelFreqForecasts", onefile = FALSE)
#pdf(file=pdf("/usr/people/wagenaa/Den_Helder/Attribute_diagrams/Medium_surge/RelFreqForecasts.pdf")

#grid_arrange_shared_legend(p1, p2, p3)
#grid.arrange(p1, p2, p3, ncol=2)
#relfreq_48_08 = verification3$prob.y
#relfreq_48_13 = verification4$prob.y
#relfreq_48120_08 = verification$prob.y
#relfreq_48120_13 = verification2$prob.y
#relfreq_120240_08 = verification5$prob.y
#relfreq_120240_13 = verification6$prob.y 

#data <- structure(list(V1 = verification3$y.i, 
                      

#hist(bins, relfreq_48120_08, col="red")
#hist(bins, relfreq_48120_13, add=T, col=rgb(0, 1, 0, 0.5) )

#hist(bins, relfreq_120240_08, col="red")
#hist(bins, relfreq_48240_13, add=T, col=rgb(0, 1, 0, 0.5) )

#dev.off()

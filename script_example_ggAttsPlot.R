#import libraries
library(ggplot2)
library(gridExtra)
library(verification)
input_files = "/usr/people/wagenaa/Delfzijl/Medium_surge/48-120hr_Delfzijl_Mediumsurge/0809101112_48-120hr_Delfzijl_Mediumsurge.csv"
input_files2 = "/usr/people/wagenaa/Delfzijl/Medium_surge/48-120hr_Delfzijl_Mediumsurge/13141516_48-120hr_Delfzijl_Mediumsurge.csv"
my_data = read.csv(file = input_files, header = TRUE, sep = ",")
my_data2 = read.csv(file = input_files2, header = TRUE, sep = ",")


#random observations/forecasts

#obs <- sample(0:1, 1000, replace=TRUE)
#pred <- list(fc1=sample(seq(0.05, 0.95, 0.05), 1000, replace=TRUE),
            # fc2=sample(seq(0.05, 0.95, 0.05), 1000, replace=TRUE))


#sea level probability forecast/binary observations
obs = my_data[, "event_obs"]
#obs2 = my_data2[, "event_obs"]
pred =  list(fc1=my_data[, "Pexc_brier"])
#print(length(pred))

#make the bins
bins = seq(0, 1, 0.1)
mids <- bins[-length(bins)] + 0.5 * diff(bins)
pred <- lapply(pred, function(p) cut(p, breaks = bins, include.lowest = TRUE))
pred <- lapply(pred, function(p) mids[p] )


#function for calculating relative observed frequencies, bootstrapping and plotting
ggAttsPlot <- function(obs, pred, main="", CI ="TRUE", n.boot = 1000, alpha = 0.05, tck =0.01, thresholds = thres, bins = bins){
  # for plotting multiple lines/methods/times/etc on one figure:
  if(any(is.na(obs))){
    obsna <- which(is.na(obs))
    obs <- obs[-obsna]
    pred <- lapply(pred, function(p) p[-obsna])
  }
  obar <- mean(obs)
  print (obar)
  N.pred <- lapply(pred, function(p) aggregate(p, by = list(p), length))
  print(N.pred)
  
  N.obs <- lapply(1:length(pred), function(p) aggregate(obs, by = list(pred[[p]]), sum))

  obar.i <- lapply(1:length(pred), function(p) N.obs[[p]]$x/N.pred[[p]]$x)
  #  cbind(N.pred, N.obs, obar.i)
  y.i <- lapply(N.obs, function(p) as.numeric(as.character(p$Group.1)))
  a   <- (1-obar)/2 + obar
  b   <- obar / 2
  x.p <- c(obar, obar, 1, 1, 0, 0)
  y.p <- c(0, 1, 1, a, b, 0)
  ii <- lapply(obar.i, function(p) is.finite(p))
  print("hallo")
  print(ii)   
 
  ####### bootstrap CI's
  ####### this causes a binding error since pred and obs is not introduced.
  if(CI){   
  n    <- length(pred[[1]])
  OBAR <- matrix(NA, nrow = length(obar.i[[1]]), ncol = n.boot)

  for(i in 1:n.boot){
    ind      <- sample(1:n, replace = TRUE)

  INDN.obs <- lapply(1:length(pred), function(p) aggregate(obs[ind], by = list(pred[[p]]), sum))
  #print (N.pred$x)
    
  INDobar.i <- lapply(1:length(pred), function(p) INDN.obs[[p]]$x/N.pred[[p]]$x)
  print(INDobar.i)  

#    YY       <- verify(obs[ind], pred[[1]][ind], show = FALSE, thresholds = thres, bins = bins)$obar.i    
    OBAR[,i] <- INDobar.i[[1]] #YY
  
  } ## close 1:nboot
  print (OBAR)
  lower<- apply(OBAR,1, quantile, alpha, na.rm = TRUE)
  upper<- apply(OBAR,1, quantile, 1-alpha, na.rm = TRUE)

  #for(i in 1:length(upper) ){
  print(lower);print(upper)  
    
#    lines(rep(x[i], 2), c(a[i], b[i] ), lwd = 1)
##    lines( c(x[i] - tck, x[i] + tck), rep(a[i],2),lwd = 1 )
#    lines( c(x[i] - tck, x[i] + tck), rep(b[i],2), lwd = 1 )
#  }

  # rm(OBAR, a,b)

  }
  attsdf <- lapply(1:length(y.i), function(p) data.frame(Method=gsub(".pred", "", names(pred)[p]), x=y.i[[p]][ii[[p]]], y=obar.i[[p]][ii[[p]]], lower, upper))
  attsdf <- do.call(rbind, attsdf)
  
  polydf <- data.frame(x.p, y.p)
  #print(attsdf)
  # make the size of the shape indicate the number of fcsts in each bin
  attsdf$size <- unlist(lapply(pred, function(p) as.numeric(round((table(p)/length(p)) *100))))
  attsdf$a <- a
  print(attsdf)

 attsdf$b <- b
  write.csv(attsdf, file = "bins.txt")
  pout <- ggplot(data=attsdf) +
    geom_polygon(data=polydf, mapping=aes(x=x.p, y=y.p), fill = "gray") +
    geom_line(aes(x=x, y=y, color=Method), size=1) +
    #geom_line(aes(x=x, y=a)) +
    #geom_line(aes(x=x, y=b)) +
    geom_point(aes(x=x, y=y, size=size, color="black", shape=Method))
    geom_point(aes(x=x, y=y, size=size, color=Method, shape=Method)) +
    geom_errorbar(aes(ymin = lower ,ymax = upper),width = 0.2,colour = 'red') +
    geom_errorbar(width = 0.2) +    
    geom_abline(intercept=0, slope=1) +
    geom_hline(yintercept = obar, lty = 2) +
    geom_vline(xintercept = obar, lty = 2) +
    geom_text(data=data.frame(x=0.2, y=obar-0.01, lab="No resolution"), aes(x, y, label=lab)) +
    geom_text(data=data.frame(x=0.2, y=(obar + (a-b)*(0.2 - obar))-0.01, lab="No skill"), aes(x, y, label=lab, angle=atan( a - b )/(2*pi)*360)) +
    scale_x_continuous(breaks = seq(0, 1, 0.2), limits = c(0, 1)) +
    scale_y_continuous(breaks = seq(0, 1, 0.2), limits = c(0, 1)) +
    theme_bw() +
    xlab(expression(paste("Forecast probability, ", y[i]))) +
    ylab(expression(paste("Observed relative frequency, ", bar(o)[s1]))) +
    ggtitle(main)
    
      
   return(pout)
  
}
plotout <- ggAttsPlot(obs=obs, pred=pred, main="Example")
#attsdf = read.table("bins.txt",header=TRUE, sep=",")
#print(attsdf)

#x = as.numeric(attsdf[, 3])
#print(dim(attsdf))
#y = attsdf['y']
#print("x is")

#print(x)
#print(y)
#class(x)
#class(y)
#print(length(x));print(length(a));print(length(b))
#tck = 0.01



#for(i in 1:length(a)){
    
  #plotout = plotout + geom_line(aes(x = rep(x[i], 2), y = c(a[i], b[i] ))) + 
                   #geom_line(aes(x = c(x[i] - tck, x[i] + tck), y = rep(a[i], 2))) + 
                   #geom_line(aes(x = c(x[i] - tck, x[i] + tck), y = rep(b[i], 2)))

#}

pdf(file="testingKiri.pdf")
grid.arrange(plotout, ncol=1)
dev.off()


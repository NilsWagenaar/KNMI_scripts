require("verification")
attribute.default<- function(x, obar.i,  prob.y=NULL, obar = NULL, class = "none", main = NULL,  CI = FALSE,  n.boot = 100, alpha = 0.05,  tck = 0.01, freq = TRUE, pred = NULL, obs = NULL, thres = thres, bins = FALSE, ...){
## attribute plot as displayed in Wilks, p 264.
## If the first object is a prob.bin class, information derived from that.

   old.par <- par(no.readonly = TRUE) # all par settings which
                                      # could be changed.
   # on.exit(par(old.par))

########################################
## if x is an verification object, bootstapping is possible.
   if(CI & class != "prob.bin" )  stop("x must be an 'prob.bin' object create by verify to create confidence intervals" )

########################################   

plot(x, obar.i,  col = 3, lwd = 2, type = "n",
     xlim = c(0,1), ylim = c(0,1),
     xlab =  expression( paste("Forecast probability, ", y[i] ) ),
     ylab = expression( paste("Observed relative frequency, ", bar(o)[1] ))
     )

###################  need to put down shading before anything else.

if(!is.null(obar)){
a   <- (1-obar)/2 + obar
b   <- obar / 2
x.p <- c(obar, obar, 1, 1, 0, 0)
y.p <- c(0, 1, 1, a, b, 0)

polygon(x.p, y.p, col = "gray")

text(0.6, obar + (a-b)*(0.6 - obar), "No skill", pos = 1,
     srt = atan( a - b )/(2*pi)*360 )

}

###########

ii <- is.finite(obar.i)
points(x[ii], obar.i[ii], type = "b", col = 2, lwd = 2)

####### bootstrap CI's
####### this causes a binding error since pred and obs is not introduced.
if(CI){   
n    <- length(pred)
OBAR <- matrix(NA, nrow = length(obar.i), ncol = n.boot)

for(i in 1:n.boot){
  ind      <- sample(1:n, replace = TRUE)
  YY       <- verify(obs[ind], pred[ind], show = FALSE, thresholds = thres, bins = bins)$obar.i    
  OBAR[,i] <- YY
  
} ## close 1:nboot

a<- apply(OBAR,1, quantile, alpha, na.rm = TRUE)
b<- apply(OBAR,1, quantile, 1-alpha, na.rm = TRUE)

for(i in 1:length(a) ){
 lines(rep(x[i], 2), c(a[i], b[i] ), lwd = 1)
 lines( c(x[i] - tck, x[i] + tck), rep(a[i],2),lwd = 1 )
 lines( c(x[i] - tck, x[i] + tck), rep(b[i],2), lwd = 1 )
}

rm(OBAR, a,b)

} ## close if CI

   
   
## plot relative frequency of each forecast
if(freq){
ind<- x< 0.5
text(x[ind], obar.i[ind], formatC(prob.y[ind], format = "f", digits = 3),
          pos = 3, offset = 2, srt = 90)
text(x[!ind], obar.i[!ind], formatC(prob.y[!ind], format = "f", digits = 3),
          pos = 1, offset = 2, srt = 90)
}
if(is.null(main)){title("Attribute Diagram")}else
{title(main)}

abline(0,1)

## resolution line
if(!is.null(obar)){
abline(h = obar, lty = 2)
abline(v = obar, lty = 2)
text( 0.6, obar, "No resolution", pos = 3)
}

invisible()
}

input_file1 = "/usr/people/wagenaa/Den_Helder/Medium_surge/48-120hr_Den_Helder_Mediumsurge/0809101112_48-120hr_Den_Helder_Mediumsurge.csv"
input_file2 = "/usr/people/wagenaa/Den_Helder/Medium_surge/48-120hr_Den_Helder_Mediumsurge/13141516_48-120hr_Den_Helder_Mediumsurge.csv"


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

attribute.prob.bin<- function(x, ...){
# retreives data from a verify object.

assign("obar.i", x$obar.i)
assign("thres", x$thres)
assign("prob.y", x$prob.y)
assign("obar", x$obar)
assign("class", "prob.bin")
assign("obs", x$obs)
assign("pred", x$pred)
assign("bins", x$bins)
assign("x", x$y.i)

do.call("attribute.default", list(x, obar.i, prob.y, obar, class, obs=obs, pred = pred, thres = thres, bins = bins,...))

res <- attribute.default(x$y.i, obar.i=x$obar.i, prob.y=x$prob.y, obar=x$obar,
    class="prob.bin", obs=x$obs, pred=x$pred, thres=x$thres, bins=x$bins, ...)
return(res)
}

attribute.prob.bin(verification)
attribute.default(verification, main = "Attribute diagram for 48-120hr lead time at Den Helder", CI = TRUE, freq = FALSE, bins = FALSE)
leg.txt = c("2008-2012")
legend(0.05, 0.95, leg.txt, col = c("red"), lwd = 2)
dev.off()


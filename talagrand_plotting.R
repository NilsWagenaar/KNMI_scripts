require(ggplot2)
require(gridExtra)

straight_line = 0
#0-48hr, positive astro, positive surge
observed_frequencies1 = c(15.2, 2.54, 0.97, 1.02, 0.93, 0.89, 0.25, 0.68, 1.02, 0.76, 0.72, 0.38, 0.47, 0.42, 0.63, 0.68, 0.51, 0.59, 0.55, 0.51, 0.3, 0.42, 0.59, 0.3, 0.51, 0.34, 0.25, 0.42, 0.47 ,0.47 ,0.47, 0.3, 0.25, 0.51, 0.42, 0.59, 0.47, 0.55, 0.76, 0.95, 0.45, 0.76, 0.55, 0.42, 0.68, 0.63, 1.4, 0.8, 1.4, 1.4, 2.12, 2.83, 47.5)
ranks = c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39, 40, 41,42,43,44,45,46,47,48,49,50,51,52,53)
print(length(observed_frequencies1))
relative_ranks1 = ranks/53*100
cum_frequencies1 = c(15.2, 17.74, 18.71, 19.73, 20.66, 21.55, 21.8, 22.48, 23.5, 24.26, 24.98, 25.36, 25.83, 26.25, 26.88, 27.56, 28.07, 28.66, 29.21, 29.72, 30.02, 30.44, 31.03, 31.33, 31.84, 32.18, 32.43, 32.85, 33.32, 33.79, 34.26, 34.56, 34.81, 35.32, 35.74, 36.33, 36.8, 37.35, 38.11, 39.06, 39.51, 40.27, 40.82, 41.24, 41.92, 42.55, 43.95, 44.75, 46.15, 47.55, 49.67, 52.5, 100.0)



dataframe1 = data.frame(ranks = ranks, observed_frequencies1 = observed_frequencies1, relative_ranks = relative_ranks1, cum_freq = cum_frequencies1)
print(dataframe1)
p1 <-ggplot(dataframe1, aes(x = ranks, y = observed_frequencies1))
p1 = p1 +geom_bar(stat = "identity")  + xlab("Bin number") + ylab("Obs frequencies [%]") + ggtitle("0-48hr, hastr>0, hobs>0") +  theme(plot.title = element_text(size = 10, face = "bold"))

p2 <-ggplot(dataframe1, aes(x = relative_ranks, y = cum_freq))
p2 = p2 +geom_line() +geom_point(size = 0.75)  + geom_abline(intercept = 0, slope = 1, size = 0.5) + xlab("ENS probability [%]") + ylab("Obs.  frequencies [%]") +ylim(0, 100) + ggtitle("0-48hr, hastr>0, hobs>0") +  theme(plot.title = element_text(size = 10, face = "bold"))



# 84-120hr positive astro, positive surge
observed_frequencies2 = c(1.96, 1.2, 1.31, 1.74, 1.85, 1.2, 0.98, 1.09, 0.87, 1.53, 1.2, 0.98, 1.2, 1.42, 1.64, 0.98, 0.87, 1.42, 1.09, 0.98, 1.53, 1.74, 2.07, 0.76, 1.09, 1.64, 1.31,
1.64, 1.64, 1.85, 1.09, 1.53, 1.96, 1.53, 1.09, 1.2, 1.42, 1.09, 1.53, 1.74, 1.53, 0.98, 1.2, 2.29, 2.18, 2.94, 2.84, 2.18, 2.73, 2.51, 5.02, 4.46, 14.18)
cum_frequencies2 = c(1.96, 3.16, 4.47, 6.21, 8.06, 9.26, 10.24, 11.33, 12.2, 13.73, 14.93, 15.91, 17.11, 18.53, 20.17, 21.15, 22.02, 23.44, 24.53, 25.51, 27.04, 28.78, 30.85, 31.61, 32.7, 34.34, 35.65, 37.29, 38.93, 40.78, 41.87, 43.4, 45.36, 46.89, 47.98, 49.18, 50.6, 51.69, 53.22, 54.96, 56.49, 57.47, 58.67, 60.96, 63.14, 66.08, 68.92, 71.10, 73.83, 76.34, 81.36, 85.82, 100.0)
dataframe2 = data.frame(ranks = ranks, observed_frequencies2 = observed_frequencies2, relative_ranks = relative_ranks1, cum_freq2 = cum_frequencies2)
p3 = ggplot(dataframe2, aes(x = ranks, y = observed_frequencies2))
p3 = p3 +geom_bar(stat = "identity")  + xlab("Bin number") + ylab("Obs. frequencies [%]") +ggtitle("84-120hr, hastr>0, hobs>0") +  theme(plot.title = element_text(size = 10, face = "bold"))

p4 = ggplot(dataframe2, aes(x = relative_ranks, y = cum_freq2))
p4 = p4 +geom_line()  + geom_point(size = 0.75) + geom_abline(intercept = 0, slope = 1, size = 0.5) +  xlab("ENS probability [%]") + ylab("Obs. frequencies [%]") + ggtitle("84-120hr, hastr>0, hobs>0") +  theme(plot.title = element_text(size = 10, face = "bold"))


observed_frequencies3 = c(0.65, 1.55, 1.8, 2.2, 2.05, 2.2, 2.65, 2.15, 2.5, 2.2, 1.95, 3.2, 1.8, 1.85, 2.85, 2.65, 3.3, 2.05, 2.2, 2.5, 2.65, 2.25, 2.4, 2, 2.25, 2.35, 1.65, 1.8, 1.6, 2, 1.55, 1.65, 1.8, 1.75, 1.45, 1.85, 1.75, 2.01, 1.85, 2.1, 2, 1.51, 1.4, 1.55, 1.45, 1.17, 1.3, 1.15, 1.4, 1.05, 1.1, 1.05, 1.01)
print(length(observed_frequencies3))

cum_frequencies3 = c(0.65, 2.2, 4, 6.2, 8.25, 10.45, 13.1, 15.1, 17.6, 19.8, 21.75, 24.95, 26.75, 28.6, 31.45, 34.1, 37.4, 39.45, 41.65, 44.15, 46.8, 49.05, 51.45, 53.45, 55.7, 58.05, 59.7, 61.5, 63.1, 65.1, 66.65, 68.3, 70.1, 71.85, 73.3, 75.15, 76.9, 78.91, 80.76, 82.86, 84.86, 86.37, 87.77, 89.32, 90.77, 91.94, 93.24, 94.39, 95.79, 96.84, 97.94, 98.99, 100.0)
print(length(cum_frequencies3)) 
dataframe3 = data.frame(ranks = ranks, observed_frequencies3 = observed_frequencies3, relative_ranks = relative_ranks1, cum_freq3 = cum_frequencies3)

p5 = ggplot(dataframe3, aes(x = ranks, y = observed_frequencies3))
p5 = p5 +geom_bar(stat = "identity")  + xlab("Bin number") + ylab("Obs. frequencies [%]") + ggtitle("192-240hr, hastr>0, hobs>0") +  theme(plot.title = element_text(size = 10, face = "bold"))

p6 = ggplot(dataframe3, aes(x = relative_ranks, y = cum_freq3))
p6 = p6 +geom_line()  + geom_point(size = 0.75) + geom_abline(intercept = 0, slope = 1, size = 0.5) +  xlab("ENS probability [%]") + ylab("Obs. frequencies [%]") + ggtitle("192-240hr, hastr>0, hobs>0") + theme(plot.title = element_text(size = 10, face = "bold")) 


pdf("/usr/people/wagenaa/talagrand_plots_Vlissingen", onefile = FALSE)
grid.arrange(p1, p2, p3, p4, p5, p6, ncol = 2)


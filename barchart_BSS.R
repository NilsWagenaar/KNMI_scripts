require("ggplot2")
require("gridExtra")
require("grid")


#make string arrays 

leadtimes = c("0-48", "0-48", "48-84", "48-84","84-120", "84-120", "120-168", "120-168", "168-240", "168-240")
#years = c("2008-2012", "2013-2016", "2008-2012", "2013-2016", "2008-2012", "2013-2016", "2008-2012", "2013-2016", "2008-2012", "2013-2016")
#tides = c("Lowtide", "Hightide", "Lowtide", "Hightide", "Lowtide", "Hightide", "Lowtide", "Hightide", "Lowtide", "Hightide")
#seasons = c("Summer", "Winter", "Summer", "Winter", "Summer", "Winter", "Summer", "Winter", "Summer", "Winter")
#calibration = c("2003/04", "2015/16", "2003/04", "2015/16", "2003/04", "2015/16", "2003/04", "2015/16", "2003/04", "2015/16")
calibration = c("Cal 2006/07", "Cal 2008/12 + Bias corr", "Cal 2006/07", "Cal 2008/12 + Bias corr", "Cal 2006/07", "Cal 2008/12 + Bias corr", "Cal 2006/07", "Cal 2008/12 + Bias corr", "Cal 2006/07", "Cal 2008/12 + Bias corr")



##################################Brier Skill Scores for several locations##############################



#Vlissingen
#BSS_MS = c(0.51, 0.65, 0.41, 0.48, 0.25, 0.22, -0.018, 0.057, -0.0042, -0.046)
#BSS_NS = c(-1.0, -1.0, -0.51, -0.41, 0.026, 0.1, -0.021, -0.075, -0.11, -0.065)
#BSS_IL = c(0.048, 0.58, -0.097, 0.45, -0.46, 0.24, -0.81, -0.18, -1.09, -0.49)
#BSS_PW = c(-0.081, 0.59, -0.3, 0.34, -0.67, -0.07, -0.97, -0.29, -1.07, -0.28)

#Den Helder

#BSS_MS = c(0.66, 0.69, 0.59, 0.6, 0.33, 0.4, 0.015, 0.15, 0.0087, -0.043)
#BSS_NS = c(-1.0, -1.0, 0.3, 0.14, 0.33, 0.3, 0.17, 0.069, -0.023, -0.051)
#BSS_IL = c(0.63, 0.58, 0.57, 0.47, 0.33, 0.29, 0.16, 0.23, 0.040, -0.047)
#BSS_PW = c(0.69, 0.64, 0.65, 0.42, 0.42, 0.27, 0.12, 0.18, 0.098, -0.060)

#Huibertgat
#BSS_MS = c(0.65, 0.74, 0.55, 0.63, 0.45, 0.49, 0.17, 0.28, 0.028, 0.035)
#BSS_NS = c(-0.85, -1.0, 0.37, 0.33, 0.4, 0.36, 0.23, 0.23, -0.003, 0.04)
#BSS_IL = c(0.48, 0.57, 0.45, 0.42, 0.33, 0.28, 0.038, 0.14, -0.072, -0.091)
#BSS_PW = c(0.57, 0.71, 0.55, 0.53, 0.41, 0.35, 0.11, 0.21, -0.016, -0.050)

#Delfzijl

#BSS_MS = c(0.54, 0.57, 0.46, 0.54, 0.34, 0.41, 0.14, 0.21, 0.01, 0.023)
#BSS_NS = c(-0.24, -0.71, 0.47, 0.34, 0.43, 0.32, 0.24, 0.21, 0.059, 0.098)
#BSS_IL = c(0.51, 0.67, 0.5, 0.62, 0.39, 0.48, 0.076, 0.29, -0.058, 0.0029)
#BSS_PW = c(0.55, 0.57, 0.57, 0.51, 0.46, 0.43, 0.21, 0.37, 0.020, 0.1)

#HVH

#BSS_MS = c(0.51, 0.51, 0.33, 0.34, 0.14, 0.19, -0.047, 0.05, 0.044, -0.015)
#BSS_NS = c(-1.0, -1.0, -0.18, -0.28, 0.076, 0.11, 0.019, -0.079, -0.11, -0.11)
#BSS_IL = c(0.61, 0.57, 0.49, 0.43, 0.20, 0.29, -0.10, 0.11, -0.1, -0.074)
#BSS_PW = c(0.51, 0.47, 0.40, 0.35, 0.20, 0.11, -0.048, 0.034, -0.027, 0.0094)


##################tides#################


#HVH

#BSS_MS = c(0.48, 0.54, 0.29, 0.38, 0.15, 0.18, 0.036, -0.022, 0.0041, 0.018)
#BSS_NS = c(-1.0, -1.0, -0.22, -0.23, 0.019, 0.18, -0.11, 0.079, -0.15, -0.058)

#Den Helder

#BSS_MS = c(0.62, 0.73, 0.52, 0.67, 0.35, 0.39, 0.068, 0.12, 0.0099, -0.052)
#BSS_NS = c(-1.0, -1.0, 0.26, 0.22, 0.38, 0.24, 0.19, 0.067, -0.026, -0.041)

#Delfzijl

#BSS_MS = c(0.50, 0.64, 0.47, 0.56, 0.36, 0.40, 0.22, 0.12, 0.037, -0.015)
#BSS_NS = c(-0.57, -0.27, 0.30, 0.56, 0.27, 0.52, 0.16, 0.31, 0.054, 0.10)

########################Seasons###############################
#Delfzijl
#BSS_MS = c(0.26, 0.62, 0.14, 0.55, 0.1, 0.43, 0.008, 0.25, -0.041, -0.013)
#BSS_NS = c(-1.0, 0.27, -0.068, 0.55, 0.21, 0.46, 0.19, 0.29, 0.2, 0.096)

#Den Helder
#BSS_MS = c(0.33, 0.73, 0.26, 0.61, -0.1, 0.41, -0.23, 0.13, -0.058, -0.074)
#BSS_NS = c(-1.0, -0.44, -1.0, 0.49, -0.26, 0.42, -0.48, 0.23, -0.081, 0.027)

#HVH
#BSS_MS = c(0.17, 0.47, -0.024, 0.30, 0.19, 0.058, -0.021, -0.058, -0.026, -0.048)
#BSS_NS = c(-1.0, -1.0, -1.0, 0.25, -1.0, 0.28, -1.0, 0.094, -0.064, 0.075)


######################Calibration0910###################################

#HVH

#BSS_MS = c(0.51, 0.55, 0.33, 0.42, 0.14, 0.25, -0.047, -0.14, 0.044, -0.15)
#BSS_IL = c(0.61, 0.66, 0.49, 0.55, 0.20, 0.27, -0.10, -0.32, -0.1, -0.47)
#BSS_PW = c(0.51, 0.50, 0.40, 0.52, 0.20, 0.22, -0.048, -0.23, -0.027, -0.25)

#Delfzijl

#BSS_MS = c(0.54, 0.49, 0.46, 0.46, 0.34, 0.37, 0.14, 0.18, 0.01, -0.031)
#BSS_NS = c(-0.24, -0.71, 0.47, 0.34, 0.43, 0.32, 0.24, 0.21, 0.059, 0.098)
#BSS_IL = c(0.51, 0.51, 0.5, 0.58, 0.39, 0.48, 0.076, 0.29, 0.16, -0.077)
#BSS_PW = c(0.55, 0.61, 0.57, 0.63, 0.46, 0.51, 0.21, 0.27, 0.020, 0.0085)


#Den Helder

#BSS_MS = c(0.66, 0.60, 0.59, 0.59, 0.33, 0.41, 0.015, 0.0092, 0.0087, -0.0055)
#BSS_NS = c(-1.0, -1.0, 0.3, 0.14, 0.33, 0.3, 0.17, 0.069, -0.023, -0.051)
#BSS_IL = c(0.63, 0.67, 0.57, 0.66, 0.33, 0.53, 0.16, 0.23, 0.040, 0.068)
#BSS_PW = c(0.69, 0.69, 0.65, 0.68, 0.42, 0.58, 0.12, 0.18, 0.098, 0.13)



############################Validation1314/1516######################################

#HVH

#BSS_MS = c(0.5, 0.42, 0.41, 0.48, 0.43, 0.42, 0.33, 0.29, 0.28, 0.07, -0.0024, 0.033, 0.072, -0.086, 0.0076)
#BSS_NS = c(-1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -0.34, -1.0, -1.0, -0.38, 0.11, -0.22, -0.23, -0.32, -0.24)
#BSS_IL = c(0.66, 0.54, 0.52, 0.71, 0.61, 0.59, 0.56, 0.50, 0.48, 0.29, 0.22, 0.24, 0.18, 0.061, 0.11)
#BSS_PW = c(0.47, 0.39, 0.38, 0.55, 0.48, 0.46, 0.43, 0.38, 0.36, 0.25, 0.20, 0.22, 0.14, 0.031, 0.095)

#Delfzijl

#BSS_MS = c(0.58, 0.38, 0.33, 0.61, 0.46, 0.42, 0.53, 0.45, 0.42, 0.38, 0.38, 0.38, 0.11, 0.046, 0.0076)
#BSS_NS = c(-1.0, -1.0, -1.0, 0.21, -1.0, -1.0, 0.19, -0.66, -1.0, 0.0083, 0.075, 0.073, -0.21, -0.19, -0.076)
#BSS_IL = c(0.66, 0.45, 0.42, 0.69, 0.52, 0.49, 0.53, 0.40, 0.39, 0.34, 0.32, 0.31, 0.096, 0.043, 0.082)
#BSS_PW = c(0.65, 0.44, 0.41, 0.58, 0.42, 0.39, 0.43, 0.34, 0.32, 0.25, 0.22, 0.20, 0.1, 0.077, 0.091)

#Den Helder

#BSS_MS = c(0.67, 0.52, 0.42, 0.60, 0.53, 0.45, 0.52, 0.44, 0.38, 0.28, 0.24, 0.22, 0.13, 0.12, 0.12)
#BSS_NS = c(-1.0, -1.0, -1.0, -0.20, -1.0, -1.0 ,0.06, -1.0, -1.0, -0.095, -0.21, -0.42, -0.090, -0.21, -0.1)
#BSS_IL = c(0.55, 0.49, 0.39, 0.42, 0.47, 0.40, 0.23, 0.39, 0.36, 0.11, 0.19, 0.20, 0.055, 0.063, 0.078)
#BSS_PW = c(0.53, 0.40, 0.32, 0.46, 0.32, 0.29, 0.24, 0.066, 0.1, 0.16, 0.05, 0.0073, 0.034, 0.006, 0.02)


###############################Validation1516#################################

#HVH

#BSS_MS = c(0.5, 0.41, 0.48, 0.42, 0.33, 0.28, 0.07, 0.033, 0.072, 0.0076)
#BSS_NS = c(-1.0, -1.0, -1.0, -1.0, -0.34, -1.0, -0.38, -0.22, -0.23, -0.24)
#BSS_IL = c(0.66, 0.52, 0.71, 0.59, 0.56, 0.48, 0.29, 0.24, 0.18, 0.11)
#BSS_PW = c(0.47, 0.38, 0.55, 0.46, 0.43, 0.36, 0.25, 0.22, 0.14, 0.095)

#Delfzijl

#BSS_MS = c(0.58, 0.33, 0.61, 0.42, 0.53, 0.42, 0.38, 0.38, 0.11, 0.076)
#BSS_NS = c(-1.0, -1.0, 0.21, -1.0, 0.19, -1.0, 0.0083, 0.073, -0.21, -0.076)
#BSS_IL = c(0.66, 0.42, 0.69, 0.49, 0.53, 0.39, 0.34, 0.31, 0.096, 0.082)
#BSS_PW = c(0.65, 0.41, 0.58, 0.39, 0.43, 0.32, 0.25, 0.20, 0.1, 0.091)

#Den Helder

#BSS_MS = c(0.67, 0.42, 0.60, 0.45, 0.52, 0.38, 0.28, 0.22, 0.13, 0.12)
#BSS_NS = c(-1.0, -1.0, -0.20, -1.0, 0.06, -1.0, -0.095, -0.42, -0.090, -0.1)
#BSS_IL = c(0.55, 0.39, 0.42, 0.40, 0.23, 0.36, 0.11, 0.20, 0.055, 0.078)
#BSS_PW = c(0.53, 0.32, 0.46, 0.29, 0.24, 0.1, 0.16, 0.0073, 0.034, 0.02)

###############################Validation cal0912 / cal0912 + Cor 1317############################################

#HVH

#BSS_MS = c(0.52, 0.50, 0.39, 0.40, 0.23, 0.25, 0.063, 0.11, 0.018, 0.067)
#BSS_NS = c(-1.0, -1.0, -1.0, -1.0, -1.0, -1.0, -0.34, -1.0, -1.0, -0.38, 0.11, -0.22, -0.23, -0.32, -0.24)
#BSS_IL = c(0.63, 0.65, 0.57, 0.58, 0.43, 0.45, 0.20, 0.26, 0.051, 0.13)
#BSS_PW = c(0.48, 0.45, 0.45, 0.45, 0.28, 0.30, 0.15, 0.20, 0.086, 0.15)

#Delfzijl

#BSS_MS = c(0.58, 0.62, 0.57, 0.60, 0.44, 0.48, 0.24, 0.32, 0.032, 0.12)
#BSS_NS = c(-1.0, -1.0, -1.0, 0.21, -1.0, -1.0, 0.19, -0.66, -1.0, 0.0083, 0.075, 0.073, -0.21, -0.19, -0.076)
#BSS_IL = c(0.71, 0.68, 0.68, 0.65, 0.53, 0.54, 0.32, 0.36, 0.045, 0.14)
#BSS_PW = c(0.62, 0.65, 0.55, 0.58, 0.45, 0.47, 0.34, 0.32, 0.11, 0.13)

#Den Helder

BSS_MS = c(0.70, 0.70, 0.61, 0.62, 0.44, 0.47, 0.17, 0.22, 0.0013, 0.075)
#BSS_NS = c(-1.0, -1.0, -1.0, -0.20, -1.0, -1.0 ,0.06, -1.0, -1.0, -0.095, -0.21, -0.42, -0.090, -0.21, -0.1)
BSS_IL = c(0.60, 0.59, 0.54, 0.56, 0.38, 0.46, 0.21, 0.28, -0.017, 0.10)
BSS_PW = c(0.66, 0.62, 0.46, 0.43, 0.29, 0.26, 0.20, 0.18, -0.030, 0.058)


###########################################################

#make dataframe

dataframe = data.frame(leadtimes = leadtimes, Calibration_Period = calibration)

#assign BSS to dataframe


dataframe$Brier_Skill_Score_MediumSurge = BSS_MS
#dataframe$Brier_Skill_Score_NegSurge = BSS_NS
dataframe$Brier_Skill_Score_IL = BSS_IL
dataframe$Brier_Skill_Score_PW = BSS_PW


# function for shared legend

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


dataframe$ordered_lead <- factor(dataframe$leadtimes, c("0-48", "48-84", "84-120", "120-168", "168-240"))
print(dataframe)

#plot
 
p1 <-ggplot(dataframe, aes(x = ordered_lead, y = Brier_Skill_Score_MediumSurge, fill = Calibration_Period))
p1 = p1 +geom_bar(stat = "identity", position = "dodge") + ylim(-1.0, 1.0) + ggtitle("Medium surge") + xlab("lead-time [h]") + ylab("Brier skill score")

#p2 <-ggplot(dataframe, aes(x = ordered_lead, y = Brier_Skill_Score_NegSurge, fill = Calibration_Period))
#p2 = p2 +geom_bar(stat = "identity", position = "dodge") + ylim(-1.0, 1.0) + ggtitle("-50cm surge") + xlab("leadtime [hr]") + ylab("Brier Skill Score")


p3 <-ggplot(dataframe, aes(x = ordered_lead, y = Brier_Skill_Score_IL, fill = Calibration_Period))
p3 = p3 +geom_bar(stat = "identity", position = "dodge") + ylim(-1.0, 1.0) + ggtitle("Information level") + xlab("lead-time [h]") + ylab("Brier skill score")

p4 <-ggplot(dataframe, aes(x = ordered_lead, y = Brier_Skill_Score_PW, fill = Calibration_Period))
p4 = p4 +geom_bar(stat = "identity", position = "dodge") + ylim(-1.0, 1.0) + ggtitle("Pre-warning level") + xlab("lead-time [h]") + ylab("Brier skill score")

#make pdf
pdf("/usr/people/wagenaa/Den_Helder/BSS_plots_DH_calibration0912_corr.pdf", onefile = FALSE)

grid_arrange_shared_legend(p1, p3, p4)



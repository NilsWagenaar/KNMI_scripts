require(verification)
require(SpecsVerification)
library(Rcpp)
library(tools)



#input_file = "/usr/people/wagenaa/CRPS_merged_members/06514/merged_frc_0-48hr.csv"

#input_file3 = "/usr/people/wagenaa/Vlissingen/-50_surge/48hr_Vliss_-50surge/0809101112_48hr_Vliss_-50surge.csv"
#input_file4 = "/usr/people/wagenaa/Vlissingen/-50_surge/48hr_Vliss_-50surge/13141516_48hr_Vliss_-50surge.csv"


dataframe = data.frame(matrix(ncol = 2, nrow = 0))
x <- c("leadtime", "CRPSS")
colnames(dataframe) <- x

CRPSS_calc = function(input_file){


filename = file_path_sans_ext(basename(input_file))
#print(filename)

#load csv data files


MyData <- read.csv(file=input_file, header=TRUE, sep=",")


#print(MyData)
kens    <- grep("mbr", names(MyData))
sourceCpp("crps_ensemble.cpp")

crps.raw  <- crps_ensemble(as.matrix(MyData[,kens]), as.numeric(MyData$hobs))
#print (crps.raw)
CRPS = mean(crps.raw)

print (CRPS)
#hobs = MyData$hobs
#print (length(hobs))
#Obs_Ens = ClimEns(hobs, leave.one.out = FALSE)
#print(Obs_Ens)
#qs = seq(0, 1, 0.02)
#quantiles = quantile(hobs, qs)
#print(qs)
#print (length(quantiles))

#clim_vec = c()
#for (i in 1:51){
 # clim_vec[i] = quantiles[[i]]
#}
#print (clim_vec)
#Obs_Matrix = matrix(rep(clim_vec, length(hobs)), ncol = length(quantiles), nrow = length(hobs))

#crps.clim = crps_ensemble(Obs_Matrix, as.numeric(MyData$hobs))
#CRPS_clim = mean(crps.clim)
CRPS_clim = 11.47
print (CRPS_clim)
CRPSS = 1 - (CRPS/CRPS_clim)

#print(CRPSS)

leadtime = regmatches(filename, regexec("merged_frc_(.+).+", filename))[[1]][2]
#tfmax = gsub('.{1}$', '', leadtime)
print (leadtime)

dataframe = data.frame(leadtime = leadtime, CRPSS = CRPSS)
#dataframe <- rbind(dataframe, data.frame(leadtime = leadtime, CRPSS = CRPSS))
print(dataframe)


}



files <- list.files(path="/usr/people/wagenaa/CRPS_merged_members/Summer/06520/", pattern="*.csv", full.names=T, recursive=FALSE)
#print (files)
dataframe = lapply(files, CRPSS_calc) 
#print (dataframe)
dataframe = do.call(rbind, dataframe)
write.csv(dataframe, file = "/usr/people/wagenaa/CRPSS_tables/06520_Summer.csv")

#input_file = "/usr/people/wagenaa/CRPS_merged_members/06520/Climatology/climatology_06520.csv"

#MyData <- read.csv(file=input_file, header=TRUE, sep=",")

#hobs = MyData$hobs
#qs = seq(0, 1, 0.02)
#quantiles = quantile(hobs, qs)

#clim_vec = c()
#for (i in 1:51){
  #clim_vec[i] = quantiles[[i]]
#}
#Obs_Matrix = matrix(rep(clim_vec, length(hobs)), ncol = length(quantiles), nrow = length(hobs))
#sourceCpp("crps_ensemble.cpp")

#crps.clim = crps_ensemble(Obs_Matrix, as.numeric(MyData$hobs))
#CRPS_clim = mean(crps.clim)

#print (CRPS_clim)

#CRPS_climatology_DenH = 13.05
#CRPS_climatology_HVH = 11.6
#CRPS_climatology_DFZ = 17.23
#CRPS_climatology_Huib = 14.17
#CRPS_climatology_Vliss = 11.47







#print(MyData)
#h_obs = MyData[ , "hobs"]
#print(h_obs)
#Mu = MyData[ ,"hmean"]
#print (h_obs)
#print(Predictions)
#sigma = MyData[ ,"sigma"]
#matrix =  cbind(Mu, sigma)
#print(matrix)
#rank_score = crps(h_obs, matrix)
#print(matrix[,1])
#print(rank_score)
#clim = c(4, 32.1)
#climatology = ClimEns(h_obs, leave.one.out=FALSE)
#print(climatology)
#meanclimatology = colMeans(climatology)
#print(meanclimatology)

#rank_score_clim = crps(h_obs, clim)
#print(rank_score_clim)
#rank_score = rank_score$CRPS
#rank_score_clim = rank_score_clim$CRPS
#CRPSS = 1 - (rank_score/rank_score_clim)
#print(CRPSS)

require(verification)
require(SpecsVerification)
library(Rcpp)
library(tools)



dataframe = data.frame(matrix(ncol = 2, nrow = 0))
x <- c("leadtime", "CRPSS")
colnames(datafra

# function for CRPSS calc
CRPSS_calc = function(input_file){


filename = file_path_sans_ext(basename(input_file))

#load data
MyData <- read.csv(file=input_file, header=TRUE, sep=",")

#ensemble names
kens    <- grep("mbr", names(MyData))

#load c script for CRPS calc
sourceCpp("crps_ensemble.cpp")


#calc CRPS for the ensemble

crps.raw  <- crps_ensemble(as.matrix(MyData[,kens]), as.numeric(MyData$hobs))
#print (crps.raw)

#calc the mean of the CRPS of the ensemble
CRPS = mean(crps.raw)

print (CRPS)



#CRPS for climatology for location along the Dutch coast
CRPS_clim = 11.6
print (CRPS_clim)
#calc CRPSS
CRPSS = 1 - (CRPS/CRPS_clim)

#put CRPSS for corresponding lead-time in a file
leadtime = regmatches(filename, regexec("merged_frc_(.+).+", filename))[[1]][2]
print (leadtime)
dataframe = data.frame(leadtime = leadtime, CRPSS = CRPSS)

print(dataframe)


}

########################CRPS_Climatology#####################################
#climatology file
input_file = "/usr/people/wagenaa/CRPS_merged_members/06520/Climatology/climatology_06520.csv"

MyData <- read.csv(file=input_file, header=TRUE, sep=",")
# generate quantiles bas on hobs to generate climatological ensemble forecasts
hobs = MyData$hobs
qs = seq(0, 1, 0.02)
quantiles = quantile(hobs, qs)
clim_vec = c()
for (i in 1:51){
  clim_vec[i] = quantiles[[i]]
}
Obs_Matrix = matrix(rep(clim_vec, length(hobs)), ncol = length(quantiles), nrow = length(hobs))

#calc CRPS
sourceCpp("crps_ensemble.cpp")
crps.clim = crps_ensemble(Obs_Matrix, as.numeric(MyData$hobs))
CRPS_clim = mean(crps.clim)
print (CRPS_clim)


################################CRPS_ensemble_forecasts#######################################
files <- list.files(path="/usr/people/wagenaa/CRPS_merged_members/NEG_HT/06514/", pattern="*.csv", full.names=T, recursive=FALSE)
#apply function to all files
dataframe = lapply(files, CRPSS_calc) 

#write dataframe to file
dataframe = do.call(rbind, dataframe)
write.csv(dataframe, file = "/usr/people/wagenaa/CRPSS_tables/HVH_Surge_Tides/06514_NEG_HT.csv")


#CRPS_climatology_DenH = 13.05
#CRPS_climatology_HVH = 11.6
#CRPS_climatology_DFZ = 17.23
#CRPS_climatology_Huib = 14.17
#CRPS_climatology_Vliss = 11.47





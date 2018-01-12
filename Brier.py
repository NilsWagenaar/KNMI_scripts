#load required modules and scripts
import pandas as pd
import numpy as np
import os
import sys
import glob
import fnmatch

#input/output files

input_files = {}
output_files = {}
#input_files['main_folder'] = "/usr/people/wagenaa/test/13-16/"
input_files['main_folder'] = "/usr/people/wagenaa/Cal_ENS_0912_cor1317/"
output_files['output_txt_file'] = input_files['main_folder'] + "brier_skill.txt"
station_folders  = glob.glob(input_files['main_folder'] + "/*/")


#Climatologies 2008/2016 calculated in excel
Vliss_MS = 0.007
Vliss_NS = 0.0099
Vliss_IL = 0.0026
Vliss_PW = 0.00075
Den_Helder_MS = 0.0084
Den_Helder_NS = 0.017
Den_Helder_IL = 0.0041
Den_Helder_PW = 0.0017
Huibert_MS = 0.014
Huibert_NS = 0.022
Huibert_IL = 0.0038
Huibert_PW = 0.0028
Delfzijl_MS = 0.020
Delfzijl_NS = 0.043
Delfzijl_IL = 0.0031
Delfzijl_PW = 0.0020
HVH_MS = 0.0054
HVH_NS = 0.0096
HVH_IL = 0.0065
HVH_PW = 0.0022


#make txt file
txt_file_out = open(output_files['output_txt_file'], 'w')
initial_print = "filename" + ';' + 'Brier_Skill_Score'+ '\n' 
txt_file_out.write(initial_print)


#functions to convert observations to binary observations
def f_mediumsurge(row):
    if row['hobs'] > row['lvl']:
        val = 1
    else:
        val = 0
    return val

def f_negsurge(row):
    if row['hobs'] < row['lvl']:
        val = 1
    else:
	val = 0
    return val

def f_IL_PW(row):
    if (row['hobs'] + row['hastr']) > row['lvl']:
        val = 1
    else:
	val = 0
    return val


#General function to calculate Brier skill score 

def Brier_calc_years(file, station):            
    data = pd.read_csv(file, delimiter = "\t")
    print station            
   
    # apply binary conversion function based on lvl column
 	
    if (data.iloc[0]['lvl'] >= 0 & data.iloc[0]['lvl'] <= 100):
        data['event_obs'] = data.apply(f_mediumsurge, axis=1)

    elif data.iloc[0]['lvl'] <0:
        data['event_obs'] = data.apply(f_negsurge, axis=1)
    
    data['total_wl'] = data['hobs'] + data['hastr']

    if data.iloc[0]['lvl'] > 100:
        
        data['event_obs'] = (data['total_wl'] > data['lvl']).astype(int)
        
        
            
    #convert exceedance probability column
    data['Pexc_brier'] = data['Pexc'] / 100
    
    #Brier score forecast calc
    data['Brier_score_fc'] = (data['Pexc_brier'] -  data['event_obs'])**2
    
    #  Brier score climatology calc
    print "this is", data.ix[0,8]
    #conditions to assign certain climatological probability event occurence to location and surge level
    if station == '06511':
        
        if data.ix[0, 8]<0:
            climatology = Delfzijl_NS 
        elif data.ix[0, 8]>0 & data.ix[0,8]<100:
            climatology = Delfzijl_MS
        value = data.ix[0, 8]
        
        if value ==240:
            climatology = Delfzijl_IL
	    print data.ix[(data['hobs'] + data['hastr']>data['lvl'])]        
        
        elif value == 260:
            
            climatology = Delfzijl_PW
    
    if station == '06512':
        if data.ix[0, 8]<0:
            climatology = Den_Helder_NS 
   
        elif data.ix[0, 8]>0 & data.ix[0, 8]<100:
            climatology = Den_Helder_MS
        value = data.ix[0, 8]    
        print value
    
        if value == 150:
            climatology = 0.0041
        elif value == 170:
            climatology = 0.0017
    #print climatology
    if station == '06514':
        if data.ix[0, 8]<0:
            climatology = HVH_NS 
        elif data.ix[0, 8]>0 & data.ix[0,8]<100:
            climatology = HVH_MS
        value = data.ix[0, 8]
 
        if value == 180:
            climatology = HVH_IL
        elif value == 200:
            climatology = HVH_PW
   
    if station == '06515':
        if data.ix[0, 8]<0:
            climatology = Huibert_NS 
        elif data.ix[0, 8]>0 & data.ix[0,8]<100:
            climatology = Huibert_MS
        value = data.ix[0, 8]
        if value == 185:
            
            climatology = Huibert_IL
        elif value == 195:
            climatology = Huibert_PW
    print data.ix[0, 8]
    if station == '06520':
        if data.ix[0, 8]<0:
           lvl = '-50surge' 
           climatology = Vliss_NS 
       	elif data.ix[0,8] == 75:
            climatology = Vliss_MS
	    lvl = 'Medium surge'        
        value = data.ix[0, 8]
 
        if value == 290:
            climatology = Vliss_IL
            lvl = 'Information level'
        elif value == 310:
            lvl = 'Pre-warning level'
            climatology = Vliss_PW
        print lvl
    print climatology

    #assign climatology to dataframe
    data['climatology'] = climatology
    #calc Brier score climatology
    data['Brier_clim'] = (data['climatology'] - data['event_obs'])**2
    #calculate average Brier score for both forecast and clim

    av_brier_fc = (data['Brier_score_fc'].sum())/len(data.index)
    print av_brier_fc
    av_brier_clim = (data['Brier_clim'].sum())/len(data.index)
    print data
    #substitute in skill score   
    skill_score = 1-(av_brier_fc/av_brier_clim)
    print skill_score
    print str(file)
    # print to txt file
    print_to_screen = str(file) + ";" + str(skill_score) +'\n'
    txt_file_out.write(print_to_screen)


#Function to calculate Brier score for low/high summer/winter forecasts. Same as function above but without PW and IL brier score calc

def Brier_calc_tides_seasons(file, station):            
    data = pd.read_csv(file, delimiter = "\t")
    print station            
    
    if (data.iloc[0]['lvl'] >= 0 & data.iloc[0]['lvl'] <= 100):
        data['event_obs'] = data.apply(f_mediumsurge, axis=1)

    elif data.iloc[0]['lvl'] <0:
        data['event_obs'] = data.apply(f_negsurge, axis=1)

    data['Pexc_brier'] = data['Pexc'] / 100
    
    data['Brier_score_fc'] = (data['Pexc_brier'] -  data['event_obs'])**2
    
    print "this is", data.ix[0,8]
    if station == '06511':
        if data.ix[0, 8]<0:
            climatology = Delfzijl_NS 
        elif data.ix[0, 8]>0 & data.ix[0,8]<100:
            climatology = Delfzijl_MS
        value = data.ix[0, 8]
    
    if station == '06512':
        if data.ix[0, 8]<0:
            climatology = Den_Helder_NS 
   
        elif data.ix[0, 8]>0 & data.ix[0, 8]<100:
            climatology = Den_Helder_MS
        value = data.ix[0, 8]    
        print value
    if station == '06514':
        if data.ix[0, 8]<0:
            climatology = HVH_NS 
        elif data.ix[0, 8]>0 & data.ix[0,8]<100:
            climatology = HVH_MS
        value = data.ix[0, 8]
 
    if station == '06515':
        if data.ix[0, 8]<0:
            climatology = Huibert_NS 
        elif data.ix[0, 8]>0 & data.ix[0,8]<100:
            climatology = Huibert_MS
    
    
    if station == '06520':
        if data.ix[0, 8]<0:
           lvl = '-50surge' 
           climatology = Vliss_NS 
        elif data.ix[0,8] == 75:
            climatology = Vliss_MS
            lvl = 'Medium surge'     
    data['climatology'] = climatology
    data['Brier_clim'] = (data['climatology'] - data['event_obs'])**2
    av_brier_fc = (data['Brier_score_fc'].sum())/len(data.index)
    print av_brier_fc
    av_brier_clim = (data['Brier_clim'].sum())/len(data.index)
    print data   
    skill_score = 1-(av_brier_fc/av_brier_clim)
    print skill_score
    print str(file)
    print_to_screen = str(file) + ";" + str(skill_score) +'\n'
    txt_file_out.write(print_to_screen)



 
#loop through folders made by function_brier script#

for i in station_folders:
    #print i
    tf_folders = os.listdir(str(i))

    for tf in tf_folders:
        tf_folder = str(i) + str(tf)
        #print tf_folder
        filelist = glob.glob(str(tf_folder) + "/*.txt")
        #print filelist
        for file in filelist:
            #output txt file name based on input file name 
            input_files['input_txt_file'] = str(file)
            # retrieve station code
            basename =  os.path.basename(file)
            basename = os.path.splitext(basename)[0]                        
            station = basename[4:9]
            # apply Brier score function
            Brier_calc_years(file, station)
            #Brier_calc_tides_seasons(file, station)
             

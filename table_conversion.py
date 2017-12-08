import pandas as pd
import numpy as np
import os
import glob
#input_file = "/usr/people/wagenaa/calibration_ENS/08-12/06514/0-48/sum_06514_0-48_200.txt"

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

def Brier_calc_years(file):            
    data = pd.read_csv(file, sep = "\t|,")
    print data
    
    if (data.iloc[0]['lvl'] >= 0 & data.iloc[0]['lvl'] <= 100):
        data['event_obs'] = data.apply(f_mediumsurge, axis=1)

    elif data.iloc[0]['lvl'] <0:
        data['event_obs'] = data.apply(f_negsurge, axis=1)
    
    data['total_wl'] = data['hobs'] + data['hastr']

    if data.iloc[0]['lvl'] > 100:

       	data['event_obs'] = (data['total_wl'] > data['lvl']).astype(int)
    print (data.loc[data['event_obs'] == 1])

    data['Pexc_brier'] = data['Pexc'] / 100
    data.to_csv(file, sep = ",")     


main_folder =  glob.glob("/usr/people/wagenaa/evaluation_ENS_1516/06512/" + "/*/")
print main_folder
for i in main_folder:
    print i
    filelist = glob.glob(str(i) + "/*.txt")
    
    print filelist
    for input_file in filelist:
        print input_file
         
        Brier_calc_years(input_file)


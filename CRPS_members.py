import pandas as pd
import numpy as np
import glob
import os

#input files

input_files = {}
input_files['main_folder1'] = "/usr/people/wagenaa/CRPS_members_adj_tf_NEGHT/2009/06514/"
tf_Folder_list = glob.glob(input_files['main_folder1'] + "/*/")

#loop through leadtime folder
for folder in tf_Folder_list:
    print folder    
    basename1 = os.path.basename(os.path.normpath(str(folder)))
    print basename1
    #basename = os.path.splitext(basename)[0]
    


    #loop through filelists and merge individual members
    filelist = glob.glob(str(folder) + "/*.txt")
    
    #generate final dataframe
    df1 = pd.DataFrame()

    #loop through files in folder
    for file in filelist:
        print file
        
        # temp dataframe
        tmp_df = pd.read_csv(file, sep = "\t")

        #get member number and change hmod column name
        member = tmp_df.ix[0, 4]
        membername = "mbr" + str(member)
        tmp_df = tmp_df.rename(columns = {'hmod': str(membername)})
        hmod_member = tmp_df[membername]
        
        #delete unnessecary columns

        del tmp_df['member']
        tastr = tmp_df['tastr']
        dtg = tmp_df['dtg']
        df1['tastr'] = tastr
        df1['dtg'] = dtg
        del tmp_df['hastr']
 
        #merge dataframes on tastr and dtg
        df1 = pd.merge(tmp_df, df1, on=['tastr', 'dtg'])
        #get columns different than hobs columns
        cols = [c for c in df1.columns if c.lower()[:4] != 'hobs']
        print df1
        #get hobs column
        hobs = df1.ix[ : , 3]

    #subset for cols to remove double hobs and reassign hobs   
    df1=df1[cols]
    df1['hobs'] = hobs

    print df1
    print len(df1.columns)
    
    ####################repeat for other years############################
    FileList2 = glob.glob("/usr/people/wagenaa/CRPS_members_adj_tf_NEGHT/2010/06514/"  + str(basename1) + "/*.txt")
    print (FileList2)
    df2 = pd.DataFrame()
    for file2 in FileList2:
    
    
        tmp_df = pd.read_csv(file2, sep = "\t")
        member = tmp_df.ix[0, 4]
    
        membername = "mbr" + str(member)
          
        tmp_df = tmp_df.rename(columns = {'hmod': str(membername)})
        hmod_member = tmp_df[membername]
        del tmp_df['member']
	del tmp_df['hastr']

        tastr = tmp_df['tastr']
        dtg = tmp_df['dtg']
        df2['tastr'] = tastr
        df2['dtg'] = dtg
        df2 = pd.merge(tmp_df, df2, on=['tastr', 'dtg'])
        cols = [c for c in df2.columns if c.lower()[:4] != 'hobs']
        hobs = df2.ix[ : , 3]
    df2=df2[cols]
    df2['hobs'] = hobs
    print len(df2.columns)
    print df2
    


    FileList3 = glob.glob("/usr/people/wagenaa/CRPS_members_adj_tf_NEGHT/2011/06514/" + str(basename1) + "/*")
    df3 = pd.DataFrame()
    for file3 in FileList3:
    
        tmp_df = pd.read_csv(file3, sep = "\t")
        member = tmp_df.ix[0, 4]
        membername = "mbr" + str(member)  
        tmp_df = tmp_df.rename(columns = {'hmod': str(membername)})
        hmod_member = tmp_df[membername]
        del tmp_df['member']
        del tmp_df['hastr']
        tastr = tmp_df['tastr']
        dtg = tmp_df['dtg']
        df3['tastr'] = tastr
        df3['dtg'] = dtg
    
        df3 = pd.merge(tmp_df, df3, on=['tastr', 'dtg'])

        cols = [c for c in df3.columns if c.lower()[:4] != 'hobs']
        hobs = df3.ix[ : , 3]
    df3=df3[cols]
    df3['hobs'] = hobs
    print df3
    print len(df3.columns)


    FileList4 = glob.glob("/usr/people/wagenaa/CRPS_members_adj_tf_NEGHT/2012/06514/" + str(basename1) + "/*")
    df4 = pd.DataFrame()
    for file4 in FileList4:
        tmp_df = pd.read_csv(file4, sep = "\t")
        member = tmp_df.ix[0, 4]
        membername = "mbr" + str(member)
        tmp_df = tmp_df.rename(columns = {'hmod': str(membername)})
        hmod_member = tmp_df[membername]
   
        del tmp_df['member']
        del tmp_df['hastr']
        tastr = tmp_df['tastr']
        dtg = tmp_df['dtg']
        df4['tastr'] = tastr
        df4['dtg'] = dtg
        df4 = pd.merge(tmp_df, df4, on=['tastr', 'dtg'])
        cols = [c for c in df4.columns if c.lower()[:4] != 'hobs']
        hobs = df4.ix[ : , 3]  
    df4=df4[cols]
    df4['hobs'] = hobs
    print df4
    print len(df4.columns)

    FileList5 = glob.glob("/usr/people/wagenaa/CRPS_members_adj_tf_NEGHT/2013/06514/" + str(basename1) + "/*")
    df5 = pd.DataFrame()

    for file5 in FileList5:
        tmp_df = pd.read_csv(file5, sep = "\t")
        member = tmp_df.ix[0, 4]
        membername = "mbr" + str(member)
        tmp_df = tmp_df.rename(columns = {'hmod': str(membername)})
        hmod_member = tmp_df[membername]
        del tmp_df['hastr']
        del tmp_df['member']
        tastr = tmp_df['tastr']
        dtg = tmp_df['dtg']
        df5['tastr'] = tastr
        df5['dtg'] = dtg
        df5 = pd.merge(tmp_df, df5, on=['tastr', 'dtg'])  
        cols = [c for c in df5.columns if c.lower()[:4] != 'hobs']
        hobs = df5.ix[ : , 3]
    df5=df5[cols]
    df5['hobs'] = hobs
   
    FileList6 = glob.glob("/usr/people/wagenaa/CRPS_members_adj_tf_NEGHT/2014/06514/" + str(basename1) + "/*")
    df6 = pd.DataFrame()

    for file6 in FileList6:
        tmp_df = pd.read_csv(file6, sep = "\t")
        member = tmp_df.ix[0, 4]
        membername = "mbr" + str(member)
        tmp_df = tmp_df.rename(columns = {'hmod': str(membername)})
        hmod_member = tmp_df[membername]
        del tmp_df['hastr']
    	del tmp_df['member']
        tastr = tmp_df['tastr']
        dtg = tmp_df['dtg']
        df6['tastr'] = tastr
        df6['dtg'] = dtg
        df6 = pd.merge(tmp_df, df6, on=['tastr', 'dtg'])
        cols = [c for c in df6.columns if c.lower()[:4] != 'hobs']
        hobs = df6.ix[ : , 3]
    df6=df6[cols]
    df6['hobs'] = hobs
    
    FileList7 = glob.glob("/usr/people/wagenaa/CRPS_members_adj_tf_NEGHT/2015/06514/" + str(basename1) + "/*")
    df7 = pd.DataFrame()

    for file7 in FileList7:
        tmp_df = pd.read_csv(file7, sep = "\t")
        member = tmp_df.ix[0, 4]
        membername = "mbr" + str(member)
        tmp_df = tmp_df.rename(columns = {'hmod': str(membername)})
        hmod_member = tmp_df[membername]
        del tmp_df['hastr']
    	del tmp_df['member']
        tastr = tmp_df['tastr']
        dtg = tmp_df['dtg']
        df7['tastr'] = tastr
        df7['dtg'] = dtg        
        df7 = pd.merge(tmp_df, df7, on=['tastr', 'dtg'])
        cols = [c for c in df7.columns if c.lower()[:4] != 'hobs']
        hobs = df7.ix[ : , 3]

    df7=df7[cols]
    df7['hobs'] = hobs

    FileList8 = glob.glob("/usr/people/wagenaa/CRPS_members_adj_tf_NEGHT/2016/06514/" + str(basename1) + "/*")
    df8 = pd.DataFrame()

    for file8 in FileList8:
        tmp_df = pd.read_csv(file8, sep = "\t")
        member = tmp_df.ix[0, 4]
        membername = "mbr" + str(member)
        tmp_df = tmp_df.rename(columns = {'hmod': str(membername)})
        hmod_member = tmp_df[membername]
        del tmp_df['hastr']
    	del tmp_df['member']
        tastr = tmp_df['tastr']
        dtg = tmp_df['dtg']
        df8['tastr'] = tastr
        df8['dtg'] = dtg
        df8 = pd.merge(tmp_df, df8, on=['tastr', 'dtg'])
    
        cols = [c for c in df8.columns if c.lower()[:4] != 'hobs']
        hobs = df8.ix[ : , 3]
    df8=df8[cols]
    df8['hobs'] = hobs

    FileList9 = glob.glob("/usr/people/wagenaa/CRPS_members_adj_tf_NEGHT/2016/06514/" + str(basename1) + "/*")
    df9 = pd.DataFrame()

    for file9 in FileList9:

    
        tmp_df = pd.read_csv(file9, sep = "\t")
        member = tmp_df.ix[0, 4]
   
        membername = "mbr" + str(member)
        tmp_df = tmp_df.rename(columns = {'hmod': str(membername)})
        hmod_member = tmp_df[membername]
        del tmp_df['hastr']
    	del tmp_df['member']
        tastr = tmp_df['tastr']
        dtg = tmp_df['dtg']
        df9['tastr'] = tastr
        df9['dtg'] = dtg
        df9 = pd.merge(tmp_df, df9, on=['tastr', 'dtg'])
        cols = [c for c in df9.columns if c.lower()[:4] != 'hobs']
        hobs = df9.ix[ : , 3]
    df9=df9[cols]
    df9['hobs'] = hobs

    # Concatenate the dataframes vertically to make multiple year dataset and save it for different lead times
    frames = [df1, df2, df3, df4, df5, df6, df7, df8]
    
    df_final = pd.concat(frames)
    df_final.to_csv("/usr/people/wagenaa/CRPS_merged_members/NEG_HT/06514/merged_frc_" + str(basename1) + ".csv", sep=",")



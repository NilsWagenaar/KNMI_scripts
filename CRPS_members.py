import pandas as pd
import numpy as np
import glob
import os

#input files

input_files = {}
input_files['main_folder1'] = "/usr/people/wagenaa/CRPS_members_adj_tf_summer/2009/06520/"
tf_Folder_list = glob.glob(input_files['main_folder1'] + "/*/")

#loop through leadtime folder
for folder in tf_Folder_list:
    print folder    
    basename1 = os.path.basename(os.path.normpath(str(folder)))
    print basename1
    #basename = os.path.splitext(basename)[0]
    


    #loop through filelists and merge individual members
    filelist = glob.glob(str(folder) + "/*.txt")
    df1 = pd.DataFrame()
    for file in filelist:
        print file
        #basename2 =  os.path.basename(file)
        #basename2 = os.path.splitext(basename2)[0]
        
#input_files['input_folder'] = "/usr/people/wagenaa/CPRS_members/2008/06514/0-48"

#FileList1 = glob.glob("/usr/people/wagenaa/CRPS_members/2008/06514/0-48/*")
        



    
        #print file
        tmp_df = pd.read_csv(file, sep = "\t")
        #hobs = tmp_df['hobs'].values
        member = tmp_df.ix[0, 4]
        #print member
        membername = "mbr" + str(member)
        #print tmp_df  
        tmp_df = tmp_df.rename(columns = {'hmod': str(membername)})
        hmod_member = tmp_df[membername]
        #hobs = tmp_df['hobs'].values
        #print hobs
        #del tmp_df['hobs']
        del tmp_df['member']
        tastr = tmp_df['tastr']
        dtg = tmp_df['dtg']
        df1['tastr'] = tastr
        df1['dtg'] = dtg
        del tmp_df['hastr']
    #df1[membername] = hmod_member
    #df1[member] = hmod_member
        df1 = pd.merge(tmp_df, df1, on=['tastr', 'dtg'])
        cols = [c for c in df1.columns if c.lower()[:4] != 'hobs']
        print df1
        hobs = df1.ix[ : , 3]

        #df1=df1[cols]
        #df1['hobs'] = hobs
    #df1['hobs'] = hobs
        #print df1
    df1=df1[cols]
    df1['hobs'] = hobs

    #df1 = df1.join(tmp_df, on = 'tastr', how)
#df1.set_index('dtg', inplace = True)
    print df1
    print len(df1.columns)
    #df1.to_csv("/usr/people/wagenaa/CRPS_merged_members/06514/test_frc_0-12hr_lowtide.csv", sep=",")

    FileList2 = glob.glob("/usr/people/wagenaa/CRPS_members_adj_tf_summer/2010/06520/"  + str(basename1) + "/*.txt")
    print (FileList2)
    df2 = pd.DataFrame()

        #file2 = "/usr/people/wagenaa/CRPS_members_adj_tf/2009/06514/" + str(basename1) + 
    for file2 in FileList2:
    
    #print file
        tmp_df = pd.read_csv(file2, sep = "\t")
        member = tmp_df.ix[0, 4]
    #print member
        membername = "mbr" + str(member)
        #print tmp_df  
        tmp_df = tmp_df.rename(columns = {'hmod': str(membername)})
        hmod_member = tmp_df[membername]
        #hobs = tmp_df['hobs'].values
        #print hobs
        #del tmp_df['hobs']
        del tmp_df['member']
	del tmp_df['hastr']

        tastr = tmp_df['tastr']
        dtg = tmp_df['dtg']
        df2['tastr'] = tastr
        df2['dtg'] = dtg
    
    #df1[membername] = hmod_member
    #df1[member] = hmod_member
        df2 = pd.merge(tmp_df, df2, on=['tastr', 'dtg'])
        cols = [c for c in df2.columns if c.lower()[:4] != 'hobs']
        hobs = df2.ix[ : , 3]

        #df2=df2[cols]
        #df2['hobs'] = hobs

    df2=df2[cols]
    df2['hobs'] = hobs

    #print df2
    #df2['hobs'] = hobs
    #hobs = df2['hobs_x'].values
    #cols = [c for c in df2.columns if c.lower()[:4] != 'hobs']
    #df2=df2[cols]
    #df2['hobs'] = hobs
    #hmod_member = tmp_df['hmod']
    #print len(tmp_df.index)    
    #tastr = tmp_df['tastr']
    #dtg = tmp_df['dtg']
    #df2['tastr'] = tastr
    #df2['dtg'] = dtg
    #df2['hobs'] = tmp_df['hobs']
    #df2[membername] = hmod_member
    #df2[member] = hmod_member
    #print df1.columns == df2.columns
    print len(df2.columns)
    print df2
    #df2.to_csv("/usr/people/wagenaa/CRPS_merged_members/06514/test2_frc_0-12hr_lowtide.csv", sep=",")
#df2.set_index('dtg', inplace= True)

    FileList3 = glob.glob("/usr/people/wagenaa/CRPS_members_adj_tf_summer/2011/06520/" + str(basename1) + "/*")
    df3 = pd.DataFrame()
    for file3 in FileList3:
    
    
        #print file
        tmp_df = pd.read_csv(file3, sep = "\t")
        member = tmp_df.ix[0, 4]
    
        #print member
        membername = "mbr" + str(member)
        #print tmp_df  
        tmp_df = tmp_df.rename(columns = {'hmod': str(membername)})
        hmod_member = tmp_df[membername]
        #hobs = tmp_df['hobs'].values

	    
    #del tmp_df['hobs']
        del tmp_df['member']
        del tmp_df['hastr']

        tastr = tmp_df['tastr']
        dtg = tmp_df['dtg']
        df3['tastr'] = tastr
        df3['dtg'] = dtg
    
    #df1[membername] = hmod_member
    #df1[member] = hmod_member
        df3 = pd.merge(tmp_df, df3, on=['tastr', 'dtg'])
    #df3['hobs'] = hobs
    #print df3
        cols = [c for c in df3.columns if c.lower()[:4] != 'hobs']
        hobs = df3.ix[ : , 3]

        #df3=df3[cols]
        #df3['hobs'] = hobs


    df3=df3[cols]
    df3['hobs'] = hobs

    #hmod_member = tmp_df['hmod']
    
    
    #tastr_tmp = tmp_df['tastr']
    #dtg = tmp_df['dtg']
    
    #df3['tastr'] = tastr
    
    
    
    #df3['dtg'] = dtg
    #df_tmpor = pd.concat([tmp_df, df3])
    #df_tmpor = df_tmpor.reset_index(drop=True)
    #df_tmpor_gpby = df_tmpor.groupby(list(df_tmpor.columns))
    #idx = [x[0] for x in df_tmpor_gpby.groups.values() if len(x) == 1]
    #print(df_tmpor.reindex(idx))
    #df3['hobs'] = tmp_df['hobs']
    #df3[membername] = hmod_member
    #df3[member] = hmod_member
    #count3 = count3 +1
    print df3
    print len(df3.columns)

#df3.set_index('dtg', inplace = True)

    FileList4 = glob.glob("/usr/people/wagenaa/CRPS_members_adj_tf_summer/2012/06520/" + str(basename1) + "/*")
    df4 = pd.DataFrame()
    for file4 in FileList4:


    #print file
        tmp_df = pd.read_csv(file4, sep = "\t")
        member = tmp_df.ix[0, 4]
    #print member
        membername = "mbr" + str(member)
    #print tmp_df  
        tmp_df = tmp_df.rename(columns = {'hmod': str(membername)})
        hmod_member = tmp_df[membername]
    #hobs = tmp_df['hobs'].values
    #print hobs
    #del tmp_df['hobs']
        del tmp_df['member']
        del tmp_df['hastr']
        tastr = tmp_df['tastr']
        dtg = tmp_df['dtg']
        df4['tastr'] = tastr
        df4['dtg'] = dtg
    
    #df1[membername] = hmod_member
    #df1[member] = hmod_member
        df4 = pd.merge(tmp_df, df4, on=['tastr', 'dtg'])
    #df4['hobs'] = hobs

        cols = [c for c in df4.columns if c.lower()[:4] != 'hobs']
        hobs = df4.ix[ : , 3]

        #df4=df4[cols]
        #df4['hobs'] = hobs

    #hmod_member = tmp_df['hmod']
    
    df4=df4[cols]
    df4['hobs'] = hobs
    #tastr = tmp_df['tastr']
    #dtg = tmp_df['dtg']
    #df4['tastr'] = tastr
    #df4['dtg'] = dtg
    #df4['hobs'] = tmp_df['hobs']
    #df4[membername] = hmod_member

    #df4[member] = hmod_member


#df4.set_index('dtg', inplace = True)

    print df4
    print len(df4.columns)

    FileList5 = glob.glob("/usr/people/wagenaa/CRPS_members_adj_tf_summer/2013/06520/" + str(basename1) + "/*")
    df5 = pd.DataFrame()

    for file5 in FileList5:

    #print file
        tmp_df = pd.read_csv(file5, sep = "\t")
        member = tmp_df.ix[0, 4]
    #print member
        membername = "mbr" + str(member)
        tmp_df = tmp_df.rename(columns = {'hmod': str(membername)})
        hmod_member = tmp_df[membername]
    #hobs = tmp_df['hobs'].values
    #print hobs
    #del tmp_df['hobs']
        del tmp_df['hastr']
        del tmp_df['member']
        tastr = tmp_df['tastr']
        dtg = tmp_df['dtg']
        df5['tastr'] = tastr
        df5['dtg'] = dtg
    
    #df1[membername] = hmod_member
    #df1[member] = hmod_member
        df5 = pd.merge(tmp_df, df5, on=['tastr', 'dtg'])
    #df5['hobs'] = hobs

        cols = [c for c in df5.columns if c.lower()[:4] != 'hobs']
        hobs = df5.ix[ : , 3]

        #df5=df5[cols]
        #df5['hobs'] = hobs

    #print tmp_df  
    #hmod_member = tmp_df['hmod']
    
    df5=df5[cols]
    df5['hobs'] = hobs
    #tastr = tmp_df['tastr']
    #dtg = tmp_df['dtg']
    #df5['tastr'] = tastr
    #df5['dtg'] = dtg
    #df5['hobs'] = tmp_df['hobs']
    #df5[membername] = hmod_member
    #df5[member] = hmod_member
    print df5

#df5.set_index('dtg', inplace = True)
    
    
    
    
    #print(df_final)
    #final_frame = pd.DataFrame()
    #frames = [df1, df2, df3, df4, df5]
    
    #df_final = pd.concat(frames)
    #print (df_final)
    #hobs = df_final['hobs_x'].values 
    #cols = [c for c in df_final.columns if c.lower()[:4] != 'hobs']
    #hobs = df_final.ix[ : , 3]

    #df_final=df_final[cols]
    #df_final['hobs'] = hobs
    #df_final.to_csv("/usr/people/wagenaa/CRPS_merged_members/Lowtide/06520/2008-2012/merged_frc_" + str(basename1) + ".csv", sep=",")


   
    FileList6 = glob.glob("/usr/people/wagenaa/CRPS_members_adj_tf_summer/2014/06520/" + str(basename1) + "/*")
    df6 = pd.DataFrame()

    for file6 in FileList6:

    #print file
        tmp_df = pd.read_csv(file6, sep = "\t")
        member = tmp_df.ix[0, 4]
    #print member
        membername = "mbr" + str(member)
        tmp_df = tmp_df.rename(columns = {'hmod': str(membername)})
        hmod_member = tmp_df[membername]
    #hobs = tmp_df['hobs'].values
    #print hobs
    #del tmp_df['hobs']
        del tmp_df['hastr']
    	del tmp_df['member']
        tastr = tmp_df['tastr']
        dtg = tmp_df['dtg']
        df6['tastr'] = tastr
        df6['dtg'] = dtg
    
    #df1[membername] = hmod_member
    #df1[member] = hmod_member
        df6 = pd.merge(tmp_df, df6, on=['tastr', 'dtg'])
    #df5['hobs'] = hobs

        cols = [c for c in df6.columns if c.lower()[:4] != 'hobs']
        hobs = df6.ix[ : , 3]

        #df6=df6[cols]
        #df6['hobs'] = hobs
    df6=df6[cols]
    df6['hobs'] = hobs
    
    print df6

    FileList7 = glob.glob("/usr/people/wagenaa/CRPS_members_adj_tf_summer/2015/06520/" + str(basename1) + "/*")
    df7 = pd.DataFrame()

    for file7 in FileList7:

    #print file
        tmp_df = pd.read_csv(file7, sep = "\t")
        member = tmp_df.ix[0, 4]
    #print member
        membername = "mbr" + str(member)
        tmp_df = tmp_df.rename(columns = {'hmod': str(membername)})
        hmod_member = tmp_df[membername]
    #hobs = tmp_df['hobs'].values
    #print hobs
    #del tmp_df['hobs']
        del tmp_df['hastr']
    	del tmp_df['member']
        tastr = tmp_df['tastr']
        dtg = tmp_df['dtg']
        df7['tastr'] = tastr
        df7['dtg'] = dtg
    
    #df1[membername] = hmod_member
    #df1[member] = hmod_member
        df7 = pd.merge(tmp_df, df7, on=['tastr', 'dtg'])
    #df5['hobs'] = hobs

        cols = [c for c in df7.columns if c.lower()[:4] != 'hobs']
        hobs = df7.ix[ : , 3]

        #df7=df7[cols]
        #df7['hobs'] = hobs

    df7=df7[cols]
    df7['hobs'] = hobs

    FileList8 = glob.glob("/usr/people/wagenaa/CRPS_members_adj_tf_summer/2016/06520/" + str(basename1) + "/*")
    df8 = pd.DataFrame()

    for file8 in FileList8:

    #print file
        tmp_df = pd.read_csv(file8, sep = "\t")
        member = tmp_df.ix[0, 4]
    #print member
        membername = "mbr" + str(member)
        tmp_df = tmp_df.rename(columns = {'hmod': str(membername)})
        hmod_member = tmp_df[membername]
    #hobs = tmp_df['hobs'].values
    #print hobs
    #del tmp_df['hobs']
        del tmp_df['hastr']
    	del tmp_df['member']
        tastr = tmp_df['tastr']
        dtg = tmp_df['dtg']
        df8['tastr'] = tastr
        df8['dtg'] = dtg
    
    #df1[membername] = hmod_member
    #df1[member] = hmod_member
        df8 = pd.merge(tmp_df, df8, on=['tastr', 'dtg'])
    #df5['hobs'] = hobs

        cols = [c for c in df8.columns if c.lower()[:4] != 'hobs']
        hobs = df8.ix[ : , 3]

        #df8=df8[cols]
        #df8['hobs'] = hobs

    df8=df8[cols]
    df8['hobs'] = hobs

    #FileList9 = glob.glob("/usr/people/wagenaa/CRPS_members_adj_tf_winter/2016/06514/" + str(basename1) + "/*")
    #df9 = pd.DataFrame()

    #for file9 in FileList9:

    #print file
     #   tmp_df = pd.read_csv(file9, sep = "\t")
     #   member = tmp_df.ix[0, 4]
    #print member
      #  membername = "mbr" + str(member)
      #  tmp_df = tmp_df.rename(columns = {'hmod': str(membername)})
      #  hmod_member = tmp_df[membername]
    #hobs = tmp_df['hobs'].values
    #print hobs
    #del tmp_df['hobs']
      #  del tmp_df['hastr']
    #	del tmp_df['member']
     #   tastr = tmp_df['tastr']
      #  dtg = tmp_df['dtg']
      #  df9['tastr'] = tastr
      #  df9['dtg'] = dtg
    
    #df1[membername] = hmod_member
    #df1[member] = hmod_member
     #   df9 = pd.merge(tmp_df, df9, on=['tastr', 'dtg'])
    #df5['hobs'] = hobs

      #  cols = [c for c in df9.columns if c.lower()[:4] != 'hobs']
      #  hobs = df9.ix[ : , 3]

        #df9=df9[cols]
        #df9['hobs'] = hobs
   # df9=df9[cols]
   # df9['hobs'] = hobs

    
    frames = [df1, df2, df3, df4, df5, df6, df7]
    
    df_final = pd.concat(frames)
    df_final.to_csv("/usr/people/wagenaa/CRPS_merged_members/Summer/06520/merged_frc_" + str(basename1) + ".csv", sep=",")


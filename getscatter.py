import os
from scipy.stats import gaussian_kde
import glob
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt 
input_files = {}
years = ("2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016")
for i in years:
    
    input_files['main_folder1'] = "/usr/people/wagenaa/scatterEPS/" + str(i) + "/06514/" 
    tf_Folder_list = glob.glob(input_files['main_folder1'] + "/*/")
    

def panel_plot_Hobs(year, folder_list):

    fig = plt.figure()
    index = 1
    plt.rcParams["axes.titlesize"] = 10
    for folder in folder_list:
        print folder    
        basename1 = os.path.basename(os.path.normpath(str(folder)))
        print basename1
        filelist = glob.glob(folder +  "/*.txt")
    
        for file in filelist:
            print file    


            df = pd.read_csv(file, sep = "\t")
            print df

            df = df[df['sigma'] != 0]
            y = (df['hmean'] - df['hobs'])/df['sigma']
        
            print y
            x = df['hmean']
            print x
    # Calculate the point density
            xy = np.vstack([x,y])
            
            z = gaussian_kde(xy)(xy)

    # Sort the points by density, so that the densest points are plotted last
            idx = z.argsort()
            x, y, z = x[idx], y[idx], z[idx]
            ax = fig.add_subplot(4, 5, index)
        
            cax = ax.scatter(x, y, c=z, s=10, edgecolor = 'None', cmap = 'plasma')
        #fig.text(0.5, 0.04, 'Hobs [cm]', ha='center', fontsize = 12)
        #fig.text(0.04, 0.5, '(Hmean - Hobs) / sigma [-]', va='center', rotation='vertical', fontsize = 12)
            ax.set_title(basename1 + "hrs", size = 10, weight = 'bold')
            index = index +1 
            plt.subplots_adjust(hspace = .4, wspace = 0.4)
            plt.locator_params('y', nbins=4)
            plt.locator_params('x', nbins=3)
            plt.ylim((-3.0,3.0))
	    plt.xlim((-150, 150))
                         
            plt.tick_params(labelsize = 9)
            #nbins=300
            z_min, z_max = -np.abs(z).max(), np.abs(z).max()
            print z_min
            #plt.pcolormesh(x, y, z, cmap='plasma', vmin=z_min, vmax=z_max)
            
            #xi, yi = np.mgrid[x.min():x.max():nbins*1j, y.min():y.max():nbins*1j]
            #zi = z(np.vstack([xi.flatten(), yi.flatten()]))
            #plt.pcolormesh(xi, yi, zi.reshape(xi.shape))
            #plt.show()
            #plt.pcolormesh(xi, yi, zi.reshape(xi.shape), cmap=plt.cm.Greens_r)


    cbar_ax = fig.add_axes([0.925, 0.25, 0.015, 0.5])
    cbar = fig.colorbar(cax, cax=cbar_ax) 
    cbar.ax.tick_params(labelsize=8)
    fig.text(0.5, 0.04, 'Hmean [cm]', ha='center', fontsize = 12)
    fig.text(0.04, 0.5, '(Hmean - Hobs) / sigma [-]', va='center', rotation='vertical', fontsize = 12)
    fig.suptitle(str(year), fontsize=18, weight = 'bold')

    plt.savefig("/usr/people/wagenaa/ScatterDensityFigures/scatter_density_06514_" + str(year) + ".pdf")
#plt.show()

for i in years:
    
    input_files['main_folder1'] = "/usr/people/wagenaa/scatterEPS/" + str(i) + "/06514/" 
    tf_Folder_list = glob.glob(input_files['main_folder1'] + "/*/")
    panel_plot_Hobs(i, tf_Folder_list)



def panel_plot_Years():
   # df_tot = pd.DataFrame()
    #years = ("0-12", "", "2011", "2012", "2013", "2014", "2015", "2016")
    #for i in years:
    input_files['main_folder1'] = "/usr/people/wagenaa/scatterEPS_years_LT" + "/06514/" 
    fig = plt.figure()
    index = 1
    folder_list = glob.glob(input_files['main_folder1'] + "/*/")
    print folder_list
    plt.rcParams["axes.titlesize"] = 10    
    for folder in folder_list:
        df_tot = pd.DataFrame()
        ax = fig.add_subplot(4, 5, index)
        print folder    
        basename1 = os.path.basename(os.path.normpath(str(folder)))
        print basename1
        filelist_year = glob.glob(folder +  "/*/")
        print basename1
    	for year_folder in filelist_year:
            print year_folder    
            basename_year = os.path.basename(os.path.normpath(str(year_folder))) 
            filelist = glob.glob(year_folder +  "/*.txt")
            for file in filelist:
                df = pd.read_csv(file, sep = "\t")
                #print df

                df = df[df['sigma'] != 0]
                df['bias'] = (df['hmean'] - df['hobs'])/df['sigma']
                #y = (df['hmean'] - df['hobs'])/df['sigma']
                df['year'] = float(basename_year)
                #print y
                #x = df['hmean']
                #print x
                df_tot = df_tot.append(df)
                #print df_tot
                #print df_tot
                y = (df['hmean'] - df['hobs'])/df['sigma']
                x = df['year']
            # Calculate the point density
                
        #xy = np.vstack([x,y])
        #print xy
                z = gaussian_kde(y)(y) 
                print z
            # Sort the points by density, so that the densest points are plotted last
                idx = z.argsort()
                x, y, z = x[idx], y[idx], z[idx]
                ax = fig.add_subplot(4, 5, index)

                cax = ax.scatter(x, y, c=z, s=10, edgecolor='', cmap = 'plasma')
                #set(gca, 'XTick', [2009 2010 2011 2012 2013 2014 2015 2016])
                #ax.set_xticklabels(['2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016'])
                ax.set_title(basename1 + "hrs", size = 10, weight = 'bold')
                #plt.colorbar(cax, ax = ax)        
        index = index + 1
        plt.subplots_adjust(hspace = .4, wspace = 0.4)
        plt.locator_params('y', nbins=4)
        plt.locator_params('x', nbins=3)
        plt.ylim((-3.0,3.0))
        #plt.xlim((2009,2016))
        #plt.xticks(range(8), [2009, 2010, 2011, 2012, 2013, 2014, 2015, 2016])
        
        plt.tick_params(axis = 'y', labelsize = 9)
        plt.tick_params(axis = 'x', labelsize = 7)
        #plt.colorbar()
    cbar_ax = fig.add_axes([0.925, 0.25, 0.015, 0.5])
    cbar = fig.colorbar(cax, cax=cbar_ax) 
    cbar.ax.tick_params(labelsize=8)
    fig.text(0.5, 0.04, 'Time [years]', ha='center', fontsize = 12)
    fig.text(0.04, 0.5, '(Hmean - Hobs) / sigma [-]', va='center', rotation='vertical', fontsize = 12)
    #fig.suptitle(str(year), fontsize=18, weight = 'bold')

    plt.savefig("/usr/people/wagenaa/ScatterDensityFigures/scatter_density_06514_years_LT_test.pdf")
panel_plot_Years()




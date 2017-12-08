import os
from scipy.stats import gaussian_kde
import glob
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt 
input_files = {}
input_files['main_folder1'] = "/usr/people/wagenaa/scatterEPS/2016/06514/"
tf_Folder_list = glob.glob(input_files['main_folder1'] + "/*/")

fig = plt.figure()
index = 1
plt.rcParams["axes.titlesize"] = 10
for folder in tf_Folder_list:
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
        x = df['hobs']
        print x
    # Calculate the point density
        xy = np.vstack([x,y])
        z = gaussian_kde(xy)(xy)

    # Sort the points by density, so that the densest points are plotted last
        idx = z.argsort()
        x, y, z = x[idx], y[idx], z[idx]
        ax = fig.add_subplot(4, 5, index)
        
        ax.scatter(x, y, c=z, s=10, edgecolor='')
        #fig.text(0.5, 0.04, 'Hobs [cm]', ha='center', fontsize = 12)
        #fig.text(0.04, 0.5, '(Hmean - Hobs) / sigma [-]', va='center', rotation='vertical', fontsize = 12)
        ax.set_title(basename1 + "hrs", size = 10, weight = 'bold')
        index = index + 1
        plt.subplots_adjust(hspace = .4, wspace = 0.4)
        plt.locator_params('y', nbins=4)
        plt.locator_params('x', nbins=3)
        plt.ylim((-2.5,2.5))
	plt.xlim((-200, 200))
        plt.tick_params(labelsize = 9)
fig.text(0.5, 0.04, 'Hobs [cm]', ha='center', fontsize = 12)
fig.text(0.04, 0.5, '(Hmean - Hobs) / sigma [-]', va='center', rotation='vertical', fontsize = 12)
fig.suptitle('2016', fontsize=18, weight = 'bold')

plt.savefig("/usr/people/wagenaa/ScatterDensityFigures/scatter_density_06514_2016.pdf")
plt.show()


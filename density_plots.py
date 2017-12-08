import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import gaussian_kde
import pandas as pd
# Generate fake data
#x = np.random.normal(size=1000)
#y = x * 3 + np.random.normal(size=1000)

fig = plt.figure()

input_file = "/usr/people/wagenaa/CRPS_members/2010/06514/168-240/CRPS_06514_168-240_member1.txt"
df = pd.read_csv(input_file, sep = "\t")
print df


x = df['hmod']
y = df['hobs']

# Calculate the point density
xy = np.vstack([x,y])
z = gaussian_kde(xy)(xy)

# Sort the points by density, so that the densest points are plotted last
idx = z.argsort()
x, y, z = x[idx], y[idx], z[idx]
ax1 = fig.add_subplot(221)

ax1.scatter(x, y, c=z, s=10, edgecolor='')
#ax.(loc="upper right")
#ax1.set_xlabel("Modeled surge [cm]")
#ax1.set_ylabel("Observed surge [cm]")



x2 = np.random.normal(size=1000)
y2 = x2 * 3 + np.random.normal(size=1000)
ax2 = fig.add_subplot(222)
xy2 = np.vstack([x2,y2])
z2 = gaussian_kde(xy2)(xy2)

ax2.scatter(x2, y2, c=z2, s=10, edgecolor='')
#ax.(loc="upper right")
#ax2.set_xlabel("Modeled surge [cm]")
#ax2.set_ylabel("Observed surge [cm]")
fig.text(0.5, 0.04, 'Modeled surge [cm]', ha='center')
fig.text(0.04, 0.5, 'Observed surge [cm]', va='center', rotation='vertical')







plt.savefig("scatter_density.pdf")
plt.show()

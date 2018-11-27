# -*- coding: utf-8 -*-
"""
Created on Sun Nov 25 21:20:20 2018

@author: Jorge Madrid
"""
from pylab import *
from scipy.optimize import curve_fit
import numpy as np
from scipy.signal import find_peaks_cwt

## Reads from csv file (easily produced by FiJi)
from numpy import genfromtxt
x, y = genfromtxt('res_curve_kohler.csv', delimiter=',',skip_header  =1 , unpack = True)

###
## Functions for sum of gaussians
def gauss(x,mu,sigma,A):
    return A*exp(-(x-mu)**2/2/sigma**2)

def bimodal(x,mu1,sigma1,A1,mu2,sigma2,A2):
    return gauss(x,mu1,sigma1,A1)+gauss(x,mu2,sigma2,A2)


##
## Fits sum of gaussians
X = np.arange(np.min(x),np.max(x),0.1)

expected=(2.5,1,1900,10,0.5,1720)
params,cov=curve_fit(bimodal,x,y,expected)
sigma=sqrt(diag(cov))
plot(x,y,color='b', label = 'recorded intensities')
plot(X,bimodal(X,*params),color='red',lw=3,label='sum of gaussians')
legend()
print(params,'\n',sigma)  

fitted_curve = bimodal(X,*params)

####
### Finds maxima and minimum
dev = np.diff(fitted_curve, n=1)
sign_change = (np.diff(np.sign(dev)) != 0)
inf_points = [index for index, x in enumerate(sign_change) if x]


max1_x = np.round(X[inf_points[0] + 1],1)
max1_y = np.int(np.round(fitted_curve[inf_points[0] + 1]))

min1_x = np.round(X[inf_points[1] + 1],1)
min1_y = np.int(np.round(fitted_curve[inf_points[1]]))

max2_x = np.round(X[inf_points[2] + 1],1)
max2_y = np.int(np.round(fitted_curve[inf_points[2] + 1]))


#####
#############################
#### COMPLETE PLOT
my_dpi = 125
fig, ax = subplots(figsize=(7.5,3.5), dpi = my_dpi)

plot(x,y,color='xkcd:bright blue', label = 'recorded intensities')
plot(X,bimodal(X,*params),color='xkcd:burnt orange',lw=3,label='sum of gaussians')
#scatter(max1_x,max1_y,color='k', label = 'peaks')
#scatter(max2_x,max2_y,color='k')
annotate(s = '({}um, {}AU)'.format(max1_x,max1_y) , xy = (max1_x,max1_y), xytext = (1,1500), 
         arrowprops=dict(arrowstyle="->", connectionstyle="arc3"))
annotate(s = '({}um, {}AU)'.format(max2_x,max2_y) , xy = (max2_x,max2_y), xytext = (9,1500),
         arrowprops=dict(arrowstyle="->", connectionstyle="arc3"))
annotate(s = '({}um, {}AU)'.format(min1_x,min1_y) , xy = (min1_x,min1_y), xytext = (1,1300),
         arrowprops=dict(arrowstyle="->", connectionstyle="arc3"))
annotate(s='', xy=(max2_x,1400), xytext=(max1_x,1400), arrowprops=dict(arrowstyle='<->'))
annotate(s = 'dx = 8.6um', xy = (4,1420))

title('Resolution evaluation for our condenser: Intensity profile')
xlabel('Position [um]')
ylabel('Intensity [AU]')

legend(loc  =4)
show()

##hlines(1600, xmin = max1_x,xmax = max2_x, linestyles = 'dashed', color = 'xkcd:dark grey')
#hlines(max1_y, xmin = 0,xmax = 7, linestyles = 'dashed', color = 'xkcd:light grey')
#hlines(max2_y, xmin = 5,xmax = 12.5, linestyles = 'dashed', color = 'xkcd:light grey')
#hlines(y = (max1_y + max2_y)/2, xmin = 5, xmax = 7, linestyles = 'dashed', color = 'xkcd:light grey')
#hlines(y = min1_y, xmin = 5, xmax = 7, linestyles = 'dashed', color = 'xkcd:light grey')
#vlines(min1_x, ymin = min1_y, ymax = (max1_y + max2_y)/2, linestyles = 'dashed', color = 'xkcd: grey')


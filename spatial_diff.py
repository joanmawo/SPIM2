import os
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.cm as cm
from PIL import Image

im = np.asarray(Image.open('r_f4-a4.tif').convert('L'))

central_int = np.mean(im[668:868,924:1124])
mean= np.mean(im)

im_dif = (im-mean)/mean

plt.imshow(im_dif, interpolation='none',  cmap=cm.seismic)
plt.colorbar()
plt.show()

im_dif_central = (im-central_int)/central_int

plt.imshow(im_dif_central, interpolation='none',  cmap=cm.seismic)
plt.colorbar()
plt.show()

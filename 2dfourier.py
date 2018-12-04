from PIL import Image
import numpy as np
from matplotlib import pyplot as plt

filename_lowNA = r'C:\Users\Jorge Andres\OneDrive - Universidad de Los Andes\kohler_datos\figures\xz306_tissue_k_f2-a0.png'
filename_highNA = r'C:\Users\Jorge Andres\OneDrive - Universidad de Los Andes\kohler_datos\figures\xz306_tissue_k_f2-a4.png'

img_lowNA = Image.open(filename_lowNA).convert('L')
img_highNA = Image.open(filename_highNA).convert('L')

f_low = np.fft.fft2(img_lowNA)
fshift_low = np.fft.fftshift(f_low)
magnitude_spectrum_low = 20*np.log(np.abs(fshift_low))

f_high = np.fft.fft2(img_lowNA)
fshift_high = np.fft.fftshift(f_high)
magnitude_spectrum_high = 20*np.log(np.abs(fshift_high))

fig, axes = plt.subplots(1,2)

axes[0].imshow(magnitude_spectrum_low)
axes[1].imshow(magnitude_spectrum_high)
cbar = plt.colorbar()

plt.show()

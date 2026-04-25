import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import make_interp_spline

data = np.loadtxt('neb.dat')
images = data[:, 0]
energies = data[:, 1]
energies -= energies[0]  

mx = np.argmax(energies)
saddle_x = images[mx]
saddle_y = energies[mx]
e_max = energies[mx]

x = np.linspace(images.min(), images.max(), 300)  
spline = make_interp_spline(images, energies, k=3)    
energies_smooth = spline(x)

plt.figure(figsize=(8, 6))

plt.plot(x, energies_smooth, color='blue')
plt.scatter(images, energies, color='red', zorder=5, label='Images')

plt.scatter(saddle_x, saddle_y, color='green', marker='o', s=100, zorder=10, label='Saddle Point')

plt.text(
    saddle_x + 0.8,
    saddle_y * 1.0, 
    f'{e_max:.4f} eV', 
    color='red',
    ha='center',
    fontweight='bold', fontsize= 12
)

plt.xlabel('Images', fontweight='bold')
plt.ylabel('Relative Energy (eV)', fontweight='bold')
plt.title('CI-NEB Migration Barrier', fontweight='bold')

plt.grid(True)
plt.legend()
plt.tight_layout()
plt.savefig("neb_barrier_smooth.png", dpi=900)
plt.show()

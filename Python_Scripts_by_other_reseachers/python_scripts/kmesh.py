import mcu
mymcu = mcu.POSCAR()
mymcu.get_2D_kmesh(origin=[0,0,0], krange=[0.2,0.2], plane='xy', npoint=[31,31])

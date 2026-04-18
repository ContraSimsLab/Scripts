from ase.io import read
from ase.dft.kpoints import bandpath

structure = read('POSCAR')

lat = structure.cell.get_bravais_lattice()
path = lat.special_path
kpts = lat.get_special_points()

num_grids=40

def k_path_output(kpts, path):
    output = f"{lat}\n{num_grids}   ! {num_grids} grids \nLine-mode\nreciprocal\n"
    i = 0
    while i < len(path) - 1:
        point1 = path[i]

        #for taking care of kpts such as 'X1'
        if i < len(path) - 2 and path[i + 1] == '1':
            point1 = path[i] + '1'
            i += 1


        #to skip commas
        if i < len(path) - 2 and path[i + 1] == ',':
            point1 = path[i + 2]
            p1_coords = kpts[point1]
            i += 1

        point2 = path[i+1]

        if i < len(path) -2  and path[i + 2] == '1':
            point2 = path[i + 1] + '1'

        if point1 == point2:
            i += 1
            continue

        p1_coords = kpts[point1]
        p2_coords = kpts[point2]

        output += f"   {p1_coords[0]:.4f}   {p1_coords[1]:.4f}   {p1_coords[2]:.4f}   ! {point1}\n"
        output += f"   {p2_coords[0]:.4f}   {p2_coords[1]:.4f}   {p2_coords[2]:.4f}   ! {point2}\n\n"

        i += 1

    return output

k_path_output = k_path_output(kpts, path)

with open("KPOINTS_ase", "w") as f:
    f.write(k_path_output)                            

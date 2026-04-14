#/b#/bin/bash
path=$(pwd)
OUT="$path/formation_energy.txt"
dir="0.95 0.96 0.97 0.98 0.99 1.00 1.01 1.02 1.03 1.04 1.05"

rm $OUT
for k in $dir; do
  cd $k/relax
  cp ../../energy_summary.txt .
  outcar_file="OUTCAR"
  poscar_file="POSCAR"
  energy_file="$path/energy_summary.txt"

if [ ! -f "$outcar_file" ]; then
    echo "OUTCAR file not found!"
    exit 1i
fi

if [ ! -f "$poscar_file" ]; then
    echo "POSCAR file not found!"
    exit 1
fi

if [ ! -f "$energy_file" ]; then
    echo "Energy file ($energy_file) not found!"
    exit 1
fi

element_symbols=$(sed -n '6p' $poscar_file)
atom_counts=$(sed -n '7p' $poscar_file)

IFS=' ' read -r -a element_array <<< "$element_symbols"
IFS=' ' read -r -a atom_counts_array <<< "$atom_counts"

if [ ${#element_array[@]} -ne ${#atom_counts_array[@]} ]; then
    echo "Mismatch between the number of elements and atom counts!"
    exit 1
fi

toten=$(grep "TOTEN" $outcar_file | tail -n 1 | awk '{print $5}')

if [ -z "$toten" ]; then
    echo "No TOTEN value found in OUTCAR"
    exit 1
fi

reference_total_energy=0.0

for i in "${!element_array[@]}"; do
    element=${element_array[$i]}
    num_atoms=${atom_counts_array[$i]}

    energy_per_atom=$(awk -v elem="$element" '$1 == elem {print $3}' $energy_file)

    if [ -z "$energy_per_atom" ]; then
        echo "Energy per atom not found for element $element in $energy_file"
        exit 1
    fi

    element_total_energy=$(echo "$num_atoms * $energy_per_atom" | bc -l)

    reference_total_energy=$(echo "$reference_total_energy + $element_total_energy" | bc -l)
done

formation_energy=$(echo "$toten - $reference_total_energy" | bc -l)
#echo " $k :" >> $OUT
#echo "Total energy TOTEN: $toten eV" >>$OUT
#echo "Reference total energy: $reference_total_energy eV" >>$OUT
echo "Formation energy: $formation_energy eV" >>$OUT
#echo "=========================================================================" >>$OUT
     cd $path
done

#/bin/bash
path=$(pwd)
OUT="$path/POSCAR.txt"
dir="0.93 0.94 0.95 0.96 0.97 0.98 0.99 1.00 1.01 1.02 1.03 1.04 1.05"

rm $OUT
for i in $dir; do
  cd $i/relax
  if [ -f "POSCAR" ]; then
    energy=$(awk 'NR>=3 && NR<=5' POSCAR)
    echo "$i:$energy">> $OUT
  else
    echo "$i:POSCAR not found" >>$OUT
  fi
     echo "" >> $OUT
     cd $path
done
  

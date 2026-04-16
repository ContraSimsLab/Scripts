#/bin/bash
path=$(pwd)
OUT="$path/energy.txt"
dir="OH_on_Co OH_on_Cu OH_on_Fe OOH_on_Co OOH_on_Cu OOH_on_Fe O_on_Co O_on_Cu O_on_Fe O2_on_Co O2_on_Cu O2_on_Fe H2O_on_Co H2O_on_Cu H2O_on_Fe"

rm $OUT
for i in $dir; do
  cd $i
  if [ -f "OUTCAR" ]; then
    energy=$(grep TOTEN OUTCAR | tail -1 | awk '{print $5}')
    echo "$i = $energy">> $OUT
  else
    echo "$i  OUTCAR not found" >> $OUT
  fi
     cd $path
done
  

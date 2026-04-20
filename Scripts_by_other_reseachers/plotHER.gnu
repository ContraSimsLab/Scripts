set terminal pngcairo enhanced font 'Arial,28' size 1600,1200
set border lw 5
set output 'HER_reaction.png'
set xlabel "{/Bold Reaction coordinate}" font "Arial,32" enhanced
set ylabel "{/Bold Free Energy (eV)}" font "Arial,32" enhanced
set key outside

# Move the legend (key) inside the graph
set key at 3.5,0.55 # Place the legend at (x=2.5, y=0.3)
set key box lw 5# Draw a box around the legend
set key width 3.5 # Add extra width for padding in the legend

# Define x-axis labels
set xtics font "Arial Bold,28"
set xtics ("H⁺ + e⁻" 1, "H*" 2, "½H₂" 3)

# Set x and y ranges (adjust based on your data)
set xrange [0.5:3.5]
set yrange [-1.5:1.5]

# Add grid for clarity
set grid front lw 2 lc rgb "gray40"

# Define line styles for the curves
set style line 1 lc rgb '#FF0000' lw 5.5 # Red
set style line 2 lc rgb '#00FF00' lw 5.5 # Green
set style line 3 lc rgb '#0000FF' lw 5.5 # Blue
set style line 4 lc rgb '#FF00FF' lw 5.5 # Magenta
set style line 5 lc rgb '#00FFFF' lw 5.5 # Cyan
set style line 6 lc rgb '#000000' lw 3.5 dashtype 2  # Black
set style line 7 lc rgb '#000000' lw 5.5  # Black
set style line 8 lc rgb '#FFA500' lw 5.5 # yellow
set style line 9 lc rgb '#FFFF00' lw 5.5 # orange

# Use `arrow` to plot horizontal lines
set arrow from 1.75,-1.3413 to 2.25,-1.3413 nohead linestyle 1 # Mo1
set arrow from 1.75,-1.3474 to 2.25,-1.3474 nohead linestyle 2 # Mo2
set arrow from 1.75,-0.8543 to 2.25,-0.8543 nohead linestyle 3 # Ni1
set arrow from 1.75,-1.2676 to 2.25,-1.2676 nohead linestyle 4 # Ni2
set arrow from 0.75,0.0 to 1.25,0.0 nohead linestyle 7 # H
set arrow from 2.75,0.0 to 3.25,0.0 nohead linestyle 7 # H
set arrow from 1.75,0.4337 to 2.25,0.4337 nohead linestyle 5 # P

# Add dotted slanted lines from Re (0,0) to other horizontal lines
set arrow from 1.25,0.0 to 1.75,-1.3413 nohead linestyle 6 # Left slanted line to Ta
set arrow from 1.25,0.0 to 1.75,-1.3474 nohead linestyle 6 # Left slanted line to Nb
set arrow from 1.25,0.0 to 1.75,-0.8543 nohead linestyle 6 # Left slanted line to W
set arrow from 1.25,0.0 to 1.75,-1.2676 nohead linestyle 6 # Left slanted line to V
set arrow from 1.25,0.0 to 1.75,0.4337 nohead linestyle 6 # Left slanted line to Mn
set arrow from 2.75,0.0 to 2.25,-1.3413 nohead linestyle 6 # Right slanted line to Ta
set arrow from 2.75,0.0 to 2.25,-1.3474 nohead linestyle 6 # Right slanted line to Nb
set arrow from 2.75,0.0 to 2.25,-0.8543 nohead linestyle 6 # Right slanted line to W
set arrow from 2.75,0.0 to 2.25,-1.2676 nohead linestyle 6 # Right slanted line to V
set arrow from 2.75,0.0 to 2.25,0.4337 nohead linestyle 6 # Right slanted line to Mn
set arrow from 1.25,0.0 to 2.75,0.0 nohead linestyle 6 # Right slanted line to Mn

# Plot a dummy graph for the legend
plot 1/0 title "Co-1" linestyle 1, \
     1/0 title "Co-2" linestyle 2, \
     1/0 title "Ni-1" linestyle 3, \
     1/0 title "Ni-2" linestyle 4, \
     1/0 title "P" linestyle 5


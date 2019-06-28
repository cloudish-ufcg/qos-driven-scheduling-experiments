set autoscale
unset log
set grid
set style data linespoints
set style fill empty
set key box bmargin center horizontal
set pointsize 1
set xtic auto
set ytic auto
# No xrange set.
# No yrange set.
set title "Requests received"
set xlabel "Simulation tick"
set ylabel "Counts"
set datafile missing 'undefined'
set terminal png size 1600, 800

set output "Allocation_Infra_Manager_1.png"
plot  "Allocation_Infra_Manager_1.dat" using 1:2 title "TastId", "Allocation_Infra_Manager_1.dat" using 1:3 title "HostId", "Allocation_Infra_Manager_1.dat" using 1:4 title "CPUAlloc", "Allocation_Infra_Manager_1.dat" using 1:5 title "MemAlloc", "Allocation_Infra_Manager_1.dat" using 1:6 title "Index", "Allocation_Infra_Manager_1.dat" using 1:7 title "Overhead"

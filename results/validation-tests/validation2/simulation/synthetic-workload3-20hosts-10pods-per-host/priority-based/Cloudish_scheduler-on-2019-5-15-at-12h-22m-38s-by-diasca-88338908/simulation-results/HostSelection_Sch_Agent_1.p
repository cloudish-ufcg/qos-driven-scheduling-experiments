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

set output "HostSelection_Sch_Agent_1.png"
plot  "HostSelection_Sch_Agent_1.dat" using 1:2 title "TastId", "HostSelection_Sch_Agent_1.dat" using 1:3 title "NumFeasibleHosts", "HostSelection_Sch_Agent_1.dat" using 1:4 title "LastHostId", "HostSelection_Sch_Agent_1.dat" using 1:5 title "LastHostIndex", "HostSelection_Sch_Agent_1.dat" using 1:6 title "LastHostNumPreemptions", "HostSelection_Sch_Agent_1.dat" using 1:7 title "BestHostNumPreemptions", "HostSelection_Sch_Agent_1.dat" using 1:8 title "LastHostCost", "HostSelection_Sch_Agent_1.dat" using 1:9 title "BestHostCost"

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

set output "Waiting_queue_Task_Agent.png"
plot  "Waiting_queue_Task_Agent.dat" using 1:2 title "TastId", "Waiting_queue_Task_Agent.dat" using 1:3 title "Runtime"

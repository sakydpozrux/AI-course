set term jpeg
set output fname.".jpg"
set xrange [1:xrg]
set yrange [min:max]
set key bottom
plot for [i=2:cols] fname using 1:i with lines title columnhead(i)

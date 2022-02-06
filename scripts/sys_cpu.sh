echo " | CPU $(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{printf( "%.1f", 100 - $1 )}')%"

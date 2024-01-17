# echo " RAM `free -m | awk '/Mem:/ { printf("%3.1f%%", $3/$2*100) }'`"
# echo " RAM `free -h | awk '/Mem:/ { print($3) }'`"
echo "RAM `free -m | awk '/^Mem:/{printf("%3.1f\n", $3/$2 * 100)}'`%"

# -- awful.widget.watch('bash -c "free -h | awk \'/^Mem/ {print $3}\'"', 5),

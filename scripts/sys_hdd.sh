echo "HDD `df -h / | awk '/\// {print $(NF-1)}'`"

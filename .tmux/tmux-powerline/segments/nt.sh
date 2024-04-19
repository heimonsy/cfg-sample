# Prints tmux session info.
# Assuems that [ -n "$TMUX"].

run_segment() {
  #   timestamp=$(date +%s)
  #   period=$(( $timestamp % 4 ))
  #   NTTMP_FILE="/tmp/cur-nt-temp-tmux"
		#
  #   if shell_is_osx; then
  #       # TEMPERATURE=$(/usr/local/bin/smc -k TC0P -r | sed 's/.*bytes \(.*\))/\1/' |sed 's/\([0-9a-fA-F]*\)/0x\1/g' | perl -ne 'chomp; ($low,$high) = split(/ /); print (((hex($low)*256)+hex($high))/4/64); print "\n";')
		# # https://github.com/lavoiesl/osx-cpu-temp
		# TEMPERATURE=$(osx-cpu-temp | cut -d ' ' -f 1)
  #       cpu_temp=${TEMPERATURE%.*}
		#
  #       # smartctl 不是很稳定
  #       if [ $period == "0" ]; then
  #           smartctl -a disk0 | grep "Temp" | cut -d" " -f 25 > /tmp/prev-nvme-temp
  #       fi
  #       nvmeTemp=$(cat /tmp/cur-nvme-temp)
  #   else
  #       #if [ $period == "0" ]; then
  #           #newnt=$(sudo nvme smart-log /dev/nvme0 | grep -i "Sensor 2" | cut -c38-40)
  #           #if [ ! -z "$newnt" ]; then
  #               #echo "$newnt" > ${NTTMP_FILE}
  #               #nvmeTemp=$newnt
  #           #fi
  #       #else
  #           #nvmeTemp=$(cat $NTTMP_FILE)
  #       #fi
		#
  #       cpu_temp=$(sensors | grep 'id 0' | cut -c17-18)
  #   fi
		#
  #   #if [ "$nvmeTemp" -gt "65" ]; then
  #       #echo -n "#[fg=red]"
  #   #fi
  #   #printf "%3s糖 ﬙%3s糖" ${nt} ${cpu_temp}
  #   #printf "%3s°c ﬙%3s°c" ${nt} ${cpu_temp}
  #   #printf "ﳕ%3s°c ﬙%3s°c" ${nt} ${cpu_temp}
  #   #printf "ﳖ%3s°c %3s°c" ${nt} ${cpu_temp}
  #   #printf "%3s°c %3s°c" ${nt} ${cpu_temp}
  #   #echo "${nvmeTemp}°c  ${cpu_temp}°c"
  #   #printf "%3s°c %3s°c" ${nvmeTemp} ${cpu_temp}
  #   printf "%3s°c" ${cpu_temp}

    mem_usage=0
    if shell_is_osx; then
		# mem_usage=$(top -l 1 -s 0 | awk '/Processes:/ {mem_total=$2}; /MemRegions:/ {mem_used=$6; printf("%.1f%%", mem_used/mem_total*100)}')
        mem_usage=$(~/bin/memusage.sh)
	else
		# echo " $(free | awk '/Mem/ {printf("%.1f", ($3/$2)*100)}')"
        mem_usage=$(free | awk '/Mem/ {printf("%.1f", ($3/$2)*100)}')
		# echo "󰍛 $(free | awk '/Mem/ {printf("%.1f", ($3/$2)*100)}')"
	fi

    if [ $(echo "$mem_usage > 85.0" | bc) -eq 1 ]; then
        echo -n "#[fg=colour196]"
    fi
    echo " $mem_usage%"
}

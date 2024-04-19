# Prints the CPU usage: user% sys% idle.

run_segment() {
	if shell_is_linux; then
		cpu_line=$(top -b -n 1 | grep "Cpu(s)" )
		cpu_user=$(echo "$cpu_line" | grep -Po "(\d+(.\d+)?)(?=%?\s?(us(er)?))")
		cpu_system=$(echo "$cpu_line" | grep -Po "(\d+(.\d+)?)(?=%?\s?(sys?))")
		cpu_idle=$(echo "$cpu_line" | grep -Po "(\d+(.\d+)?)(?=%?\s?(id(le)?))")
		usage=$(bc <<< "$cpu_user + $cpu_system")
	elif shell_is_osx; then 
		ncpu=$(sysctl -n hw.logicalcpu)
		total=$(ps -Ao %cpu= | paste -sd+ - | bc)
		usage=$(echo "scale = 2; $total / $ncpu" | bc)
	fi

	#if [ -n "$cpu_user" ] && [ -n "$cpu_system" ] && [ -n "$cpu_idle" ]; then
		#echo "${cpu_user}, ${cpu_system}, ${cpu_idle}" | awk -F', ' '{printf("%5.1f,%5.1f,%5.1f",$1,$2,$3)}'
		#return 0
	#else
	#usage=$(( cpu_user + cpu_system ))
	#printf "%4.1f%%%5.1f%%" ${cpu_user} ${cpu_system}
	printf " %4.1f%%" ${usage}
	return 1
	#fi
}

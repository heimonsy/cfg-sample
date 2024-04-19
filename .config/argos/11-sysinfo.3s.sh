#!/bin/bash

#nt=$(sudo nvme smart-log /dev/nvme0 | grep -i "Sensor 2" | cut -c38-40)

#cpu_temp=$(sensors | grep 'id 0' | cut -c17-18)

#if [ "$nt" -gt "65" ]; then
    #echo -n "#[fg=red]"
#fi
#printf "%3s糖 ﬙%3s糖" ${nt} ${cpu_temp}



# <bitbar.title>CPU Temperature</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Eric Ripa</bitbar.author>
# <bitbar.author.github>eripa</bitbar.author.github>
# <bitbar.desc>This plugin displays the current CPU temperature (requires external 'smc' binary)</bitbar.desc>
# <bitbar.dependencies>smc</bitbar.dependencies>
#
# 'smc' can be downloaded from: http://www.eidac.de/smcfancontrol/smcfancontrol_2_4.zip
# One-liner:
# curl -LO http://www.eidac.de/smcfancontrol/smcfancontrol_2_4.zip && unzip -d temp_dir_smc smcfancontrol_2_4.zip && cp temp_dir_smc/smcFanControl.app/Contents/Resources/smc /usr/local/bin/smc ; rm -rf temp_dir_smc smcfancontrol_2_4.zip

LABEL="°c"
TEMPERATURE_WARNING_LIMIT=65
#TEMPERATURE=$(/usr/local/bin/smc -k TC0P -r | sed 's/.*bytes \(.*\))/\1/' |sed 's/\([0-9a-fA-F]*\)/0x\1/g' | perl -ne 'chomp; ($low,$high) = split(/ /); print (((hex($low)*256)+hex($high))/4/64); print "\n";')
TEMPERATURE=$(sensors | grep 'id 0' | cut -c17-18)
CPU_TEMP=${TEMPERATURE%.*}

sudo nvme smart-log /dev/nvme0 | grep -i "Sensor 2" | cut -c38-40 > /tmp/cur-nvme-temp
NVME_TEMP=$(cat /tmp/cur-nvme-temp)


if [ "$NVME_TEMP" -gt "$TEMPERATURE_WARNING_LIMIT" ] ; then
  ICON="🔥"
  COLOR=" | color=red"
else
  ICON=""
  COLOR=""
fi

if [[ "$OSTYPE" != "darwin"* ]]; then
    cpu_line=$(top -b -n 1 | grep "Cpu(s)" )
    cpu_user=$(echo "$cpu_line" | grep -Po "(\d+(.\d+)?)(?=%?\s?(us(er)?))")
    cpu_system=$(echo "$cpu_line" | grep -Po "(\d+(.\d+)?)(?=%?\s?(sys?))")
    cpu_idle=$(echo "$cpu_line" | grep -Po "(\d+(.\d+)?)(?=%?\s?(id(le)?))")
else
    cpus_line=$(top -e -l 1 | grep "CPU usage:" | sed 's/CPU usage: //')
    cpu_user=$(echo "$cpus_line" | awk '{print $1}'  | sed 's/%//' )
    cpu_system=$(echo "$cpus_line" | awk '{print $3}'| sed 's/%//' )
    cpu_idle=$(echo "$cpus_line" | awk '{print $5}'  | sed 's/%//' )
fi
usage=$(bc <<< "$cpu_user + $cpu_system")
usage=$(printf "%4s%%" ${usage})


echo "$ICON${NVME_TEMP}$LABEL     ${CPU_TEMP}$LABEL  ${usage} ${COLOR}"

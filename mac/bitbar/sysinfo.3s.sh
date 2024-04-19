#!/bin/bash

LABEL="°c"
TEMPERATURE_WARNING_LIMIT=75

TEMPERATURE=$(/usr/local/bin/smc -k TC0P -r | sed 's/.*bytes \(.*\))/\1/' |sed 's/\([0-9a-fA-F]*\)/0x\1/g' | perl -ne 'chomp; ($low,$high) = split(/ /); print (((hex($low)*256)+hex($high))/4/64); print "\n";')
CPU_TEMP=${TEMPERATURE%.*}


data=$(/usr/local/bin/smartctl -a disk0 | grep "Temp" | cut -d" " -f 25)
if [ ! -z $data ]; then
    echo "$data" > /tmp/cur-nvme-temp
fi
NVME_TEMP=$(cat /tmp/cur-nvme-temp)

if [ "$NVME_TEMP" -gt "$TEMPERATURE_WARNING_LIMIT" ] ; then
  ICON="🔥"
  COLOR=" | color=red"
else
  ICON=""
  COLOR=""
fi


ncpu=$(sysctl -n hw.logicalcpu)
total=$(ps -Ao %cpu= | paste -sd+ - | bc)
usage=$(echo "scale = 2; $total / $ncpu" | bc)
usage=$(printf "%4s%%" ${usage})

echo "$ICON:${NVME_TEMP}$LABEL :${CPU_TEMP}$LABEL :${usage} | $COLOR font='MesloLGM Nerd Font'"
echo "---"

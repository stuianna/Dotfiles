#!/bin/bash

BAT0=$(cat /sys/class/power_supply/BAT0/power_now)
BAT1=$(cat /sys/class/power_supply/BAT1/power_now)

if [ "$BAT1" != "0" ]
then
	echo $(awk '{print $1*10^-6 " W"}' /sys/class/power_supply/BAT1/power_now)
	exit
elif [ "$BAT0" != "0" ]
then 
	echo "$(awk '{print $1*10^-6 " W"}' /sys/class/power_supply/BAT0/power_now)"
	exit
fi

echo ""

#!/bin/bash

if [ ${MONS_NUMBER} -eq 2 ];
then
	mons -s
	xrandr --output HDMI-1 --mode 1920x1080
	if pgrep -x 'wallpaper.sh' > /dev/null
	then

		pkill wallpaper.sh
		~/.wallpaper/wallpaper.sh &
	else
	
		~/.wallpaper/wallpaper.sh &
	fi

	if pgrep -x 'polybar' > /dev/null
	then

		pkill polybar
		polybar -r -c ~/.polybar/config example > /dev/null &
	else
	
		polybar -r -c ~/.polybar/config example > /dev/null &
	fi


elif [ ${MONS_NUMBER} -eq 1 ];
then
	mons -o

	if pgrep -x 'wallpaper.sh' > /dev/null
	then

		pkill wallpaper.sh
		~/.wallpaper/wallpaper.sh &
	else
	
		polybar -r -c ~/.polybar/config example > /dev/null &
	fi

	if pgrep -x 'polybar' > /dev/null
	then

		pkill polybar
		polybar -r -c ~/.polybar/config example > /dev/null &
	else
	
		polybar -r -c ~/.polybar/config example > /dev/null &
	fi

else
	echo "Invalid number of monitors"

fi

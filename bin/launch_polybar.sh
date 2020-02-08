pkill polybar

echo $LOCATION

if [ "$LOCATION" == "HOME" ]
then
	if type "xrandr"; then
				for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
								MONITOR=$m polybar --reload -c  ~/.polybar/config_home top &
								MONITOR=$m polybar --reload -c  ~/.polybar/config_home bottom &
									done
							else
										polybar --reload -l -c ~/.polybar/confg_home top &
										polybar --reload -l -c ~/.polybar/confg_home bottom &
	fi

elif [[ "$LOCATION" == "WORK" ]]; then
	if type "xrandr"; then
				for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
								MONITOR=$m polybar --reload -c  ~/.polybar/config_work top &
								MONITOR=$m polybar --reload -c  ~/.polybar/config_work bottom &
									done
							else
										polybar --reload -l -c ~/.polybar/confg_work top &
										polybar --reload -l -c ~/.polybar/confg_work bottom &
	fi
fi



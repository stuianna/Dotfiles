pkill polybar

if type "xrandr"; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
              MONITOR=$m polybar --reload -c  ~/.polybar/config top &
              MONITOR=$m polybar --reload -c  ~/.polybar/config bottom &
                done
            else
                  polybar --reload -l -c ~/.polybar/confg top &
                  polybar --reload -l -c ~/.polybar/confg bottom &
fi

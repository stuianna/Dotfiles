if type "xrandr"; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
              MONITOR=$m polybar --reload -c ~/.polybar/config example &
                done
            else
                  polybar --reload -c ~/.polybar/confg example &
fi

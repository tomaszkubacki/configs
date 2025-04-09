# disply this help
help:
    just --list

# shutdowns computer
get_off:
   shutdown -h now

# list available displays
displays:
   swaymsg -t get_outputs | jq '.[] | .name'

# enable *display* output
enable display="all":
    #!/usr/bin/env bash
    case {{display}} in
        "all")
            for i in `swaymsg -t get_outputs | jq '.[] | .name'`;
            do
             swaymsg output $i enable
            done
            swaymsg output DP-5 pos 0 0
            swaymsg output DP-7 pos 0 1200
            ;;
        "laptop")
            for i in `swaymsg -t get_outputs | jq '.[] | .name'`;
            do
            if [[ $i == '"eDP-1"' ]]; then
              swaymsg output $i enable
            else
              swaymsg output $i disable
            fi
            done
            ;;
        *)
            swaymsg output {{display}} enable
            ;;
    esac

# disable display output
disable display:
   swaymsg output {{display}} disable


# disable all display outputs except main laptop display
laptop:
   #!/usr/bin/env bash
   for i in `swaymsg -t get_outputs | jq '.[] | .name'`;
   do
      if [[ $i == '"eDP-1"' ]]; then
         swaymsg output $i enable
      else
         swaymsg output $i disable
      fi
   done

# disable laptop display outputs and enable external displays
not_laptop:
   #!/usr/bin/env bash
   for i in `swaymsg -t get_outputs | jq '.[] | .name'`;
   do
      if [[ $i != '"eDP-1"' ]]; then
         swaymsg output $i enable
      else
         swaymsg output $i disable
      fi
   done

# dim display for night view
night:
   light -S 1

# dim display for evening view
evening:
   light -S 4

#light display for day
day:
   light -S 25

#show typed keys on the screen
showkeys:
   wshowkeys -a bottom



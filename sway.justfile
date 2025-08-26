# suspend laptop
[group("sway")]
suspend:
    systemctl suspend

# list available displays
[group("sway")]
displays:
   swaymsg -t get_outputs | jq '.[] | .name'

# enable *display* output
[group("sway")]
enable display="all":
    #!/usr/bin/env bash
    case {{display}} in
        "all")
            for i in `swaymsg -t get_outputs | jq '.[] | .name'`;
            do
             swaymsg output $i enable
            done
            swaymsg output DP-5 pos 0 0
            swaymsg output DP-6 pos 0 0
            swaymsg output DP-7 pos 0 1200
            swaymsg output DP-9 pos 0 1200
            swaymsg output eDP-1 pos 3400 1200
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
[group("sway")]
disable display:
   swaymsg output {{display}} disable


# disable all display outputs except main laptop display
[group("sway")]
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
[group("sway")]
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
[group("sway")]
night:
   light -S 1

# dim display for evening view
[group("sway")]
evening:
   light -S 4

#light display for day
[group("sway")]
day:
   light -S 25

#show typed keys on the screen
[group("sway")]
showkeys:
   wshowkeys -a bottom



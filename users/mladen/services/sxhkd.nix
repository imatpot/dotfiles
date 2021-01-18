let
  mod = "super";
  shutter-options = "-o '%Y-%m-%d_%H%d%S.png' --remove_cursor";

in
{
  sxhkd = {
    enable = true;
    extraPath = "/run/current-system/sw/bin";

    keybindings = {
      # ---------------------- #
      # Media controls         #
      # ---------------------- #

      # Mute
      "XF86AudioMute" = "amixer -q set Master toggle";

      # Volume down
      "XF86AudioLowerVolume" = "amixer -q set Master 5%- unmute";

      # Volume up
      "XF86AudioRaiseVolume" = "amixer -q set Master 5%+ unmute";

      # Previous
      "XF86AudioPrev" = "playerctl previous";

      # Play / Pause
      "XF86AudioPlay" = "playerctl play-pause";

      # Next
      "XF86AudioNext" = "playerctl next";

      # Stop
      "XF86AudioStop" = "playerctl stop";

      # ---------------------- #
      # WM-independent hotkeys #
      # ---------------------- #

      # Terminal emulator
      "${mod} + Return" = "alacritty";

      # Program launcher
      "${mod} + @space" = "rofi -modi drun -show drun -show-icons -scroll-method 1 -diable-history";

      # Emoji picker
      "${mod} + period" = "rofi -modi emoji -show emoji";

      # Fullscreen screenshot
      "Print" = "shutter -f ${shutter-options}";

      # Active window screenshot
      "alt + Print" = "shutter -a ${shutter-options}";

      # Selection screenshot
      "shift + Print" = "shutter -s ${shutter-options}";

      # Open shutter in a window
      "super + Print" = "shutter";

      # Reload sxhkd configuration files
      "${mod} + Escape" = "pkill -USR1 -x sxhkd";

      # ---------------------- #
      # Bspwm hotkeys          #
      # ---------------------- #

      # Restart
      "${mod} + alt + {q,r}" = "bspc {quit,wm -r}";

      # Close and kill
      "${mod} + {_,shift + }q" = "bspc node -{c,k}";

      # Alternate between the tiled and monocle layouts
      "${mod} + m" = "bspc desktop -l next";

      # Send the newest marked node to the newest preselected node
      "${mod} + y" = "bspc node newest.marked.local -n newest.!automatic.local";

      # Swap the current node and the largest window
      "${mod} + g" = "bspc node -s biggest.window";

      # ---------------------- #
      # States and flags       #
      # ---------------------- #

      # Set window state
      "${mod} + {t,shift + t,s,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";

      # Set node flags
      "${mod} + ctrl + {m,x,y,z}" = "bspc node -g {marked,locked,sticky,private}";

      # ---------------------- #
      # Focus and swap         #
      # ---------------------- #

      # Focus node in the given direction
      "${mod} + {_,shift + }{j,k,i,l}" = "bspc node -{f,s} {west,south,north,east}";

      # Focus node for the given path jump
      "${mod} + {p,b,comma,period}" = "bspc node -f @{parent,brother,first,second}";

      # Focus next or previous window in the current desktop
      "${mod} + {_,shift + }c" = "bspc node -f {next,prev}.local.!hidden.window";

      # Focus next or previous desktop in the current monitor
      "${mod} + bracket{left,right}" = "bspc desktop -f {prev,next}.local";

      # Focus last node or desktop
      "${mod} + {grave,Tab}" = "bspc {node,desktop} -f last";

      # Focus older or newer node in focus history
      "${mod} + {o,i}" = "bspc wm -h off; bspc node {older,newer} -f; bspc wm -h on";

      # Focus or send to given desktop
      "${mod} + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";

      # ---------------------- #
      # Preselect              #
      # ---------------------- #

      # Preselect direction
      "${mod} + ctrl + {j,k,i,l}" = "bspc node -p {west,south,north,east}";

      # Preselect ratio
      "${mod} + ctrl + {1-9}" = "bspc node -o 0.{1-9}";

      # Cancel preselection for focused node
      "${mod} + ctrl + space" = "bspc node -p cancel";

      # Cancel preselection for focused desktop
      "${mod} + ctrl + shift + space" = "bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel";

      # ---------------------- #
      # Move and resize        #
      # ---------------------- #

      # Expand window by moving one of its side outward
      "${mod} + alt + {j,k,i,l}" = "bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}";

      # Contract window by moving one of its side inward
      "${mod} + alt + shift + {j,k,i,l}" = "bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}";

      # Move floating window
      "${mod} + {Left,Down,Up,Right}" = "bspc node -v {-20 0,0 20,0 -20,20 0}";
    };
  };
}

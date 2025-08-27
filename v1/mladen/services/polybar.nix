{pkgs, ...}: {
  polybar = {
    enable = true;
    package = pkgs.polybarFull;

    script = "polybar top &";

    config = {
      "colors" = {
        bright = "#fff";
        dim = "#333";
        background = "#ee000000";
      };

      "bar/top" = {
        width = "100%";
        height = "35";

        padding = 2;
        module-margin = 2;
        radius = 10;
        border-left = 30;
        border-top = 30;
        border-right = 30;
        border-bottom = 0;

        modules-left = "bspwm"; # TODO: Active media (Spotify)
        modules-center = "window";
        modules-right = "audio date time";

        background = "\${colors.background}";

        font-0 = "JetBrains Mono:pixelsize=12;1";
        font-1 = "Montserrat:pixelsize=12;1";
        font-2 = "RobotoMono Nerd Font Mono:pixelsize=14;3";
      };

      "module/bspwm" = {
        type = "internal/bspwm";

        label-separator = " ";

        label-focused = "";
        label-focused-font = 3;
        label-focused-foreground = "\${colors.bright}";

        label-urgent = "";
        label-urgent-font = 3;
        label-urgent-foreground = "#600";

        label-occupied = "";
        label-occupied-font = 3;
        label-occupied-foreground = "\${colors.dim}";

        label-empty = "";
        label-empty-font = 3;
        label-empty-foreground = "\${colors.dim}";
      };

      "module/window" = {
        type = "internal/xwindow";
        label-font = 2;
        label-foreground = "\${colors.dim}";
      };

      "module/audio" = {
        type = "internal/pulseaudio";

        interval = 0; # Disable ramp by scrolling

        sink = "alsa_output.usb-Logitech_G433_Gaming_Headset_000000000000-00.analog-stereo";

        label-volume = "%{T3}墳%{T2}  %percentage%%";
        label-muted = "%{T3}婢%{T2}  %percentage%%";
        label-muted-foreground = "\${colors.dim}";
      };

      "module/date" = {
        type = "internal/date";
        date = "%F";
        label = "  %date%";
        label-font = 2;
      };

      "module/time" = {
        type = "internal/date";
        time = "%H:%M";
        label = "  %time%";
        label-font = 2;
      };
    };
  };
}

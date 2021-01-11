{
  polybar = {
    enable = true;

    script = "polybar top &";

    config = {
      "colors" = {
        bright = "#fff";
        dim = "#333";
        background = "#00000000";
      };

      "bar/top" = {
        width = "100%";
        height = "35";

        padding = 2;
        module-margin = 2;

        modules-left = "bspwm";
        modules-right = "date";

        background = "\${colors.background}";

        font-0 = "JetBrains Mono:pixelsize=12;0";
        font-1 = "Montserrat:pixelsize=12;0";
        font-2 = "RobotoMono Nerd Font Mono:pixelsize=12;0";
      };

      "module/date" = {
        type = "internal/date";

        date = "%F";
        time = "%H:%M";
        label = "%date% %time%";
        label-font = 2;
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

        label-occupied = "";
        label-occupied-font = 3;
        label-occupied-foreground = "\${colors.dim}";

        label-empty = "";
        label-empty-font = 3;
        label-empty-foreground = "\${colors.dim}";
      };
    };
  };
}

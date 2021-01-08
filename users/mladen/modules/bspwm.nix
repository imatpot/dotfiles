{
  windowManager.bspwm = {
    enable = true;

    startupPrograms = [ "sxhkd" ];

    settings = {
      border_width = 2;
      borderless_monocle = true;
      gapless_monocle = true;
      split_ration = 0.5;
      window_gap = 5;
    };
  };
}

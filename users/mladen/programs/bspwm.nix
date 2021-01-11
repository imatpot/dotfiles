{
  windowManager.bspwm = {
    enable = true;

    startupPrograms = [ "sxhkd" ];

    monitors = {
      DP-2 = [ "I" "II" "III" ];
    };

    settings = {
      border_width = 5;
      borderless_monocle = true;
      gapless_monocle = true;
      split_ration = 0.5;
      window_gap = 30;

      normal_border_color = "#444444";
      focused_border_color = "#777777d";
      urgent_border_color = "#660000";
    };

    rules = {
      discord = {
        desktop = "^2";
        follow = true;
      };
    };
  };
}

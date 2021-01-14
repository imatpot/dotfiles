{
  windowManager.bspwm = {
    enable = true;

    # TODO: Download files declaretively (also not into Downloads)
    startupPrograms = [
      "sxhkd"
      "feh --bg-center /home/mladen/Downloads/nixos-nord.png"
    ];

    monitors = {
      DP-2 = [ "I" "II" "III" ];
    };

    settings = {
      border_width = 2;
      borderless_monocle = true;
      gapless_monocle = true;
      split_ration = 0.5;
      window_gap = 30;

      normal_border_color = "#444444";
      focused_border_color = "#aaaaaa";
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

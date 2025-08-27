{
  outputs,
  pkgs,
  config,
  ...
}: {
  options = {
    modules.users.kitty.enable = outputs.lib.mkEnableOption "Enable kitty";
  };

  config = outputs.lib.mkIf config.modules.users.kitty.enable {
    # https://sw.kovidgoyal.net/kitty/faq/#i-get-errors-about-the-terminal-being-unknown-or-opening-the-terminal-failing-or-functional-keys-like-arrow-keys-don-t-work
    home.shellAliases.ssh = "TERM=xterm-256color ssh";

    programs.kitty = rec {
      enable = true;

      keybindings = {};

      settings = {
        # https://sw.kovidgoyal.net/kitty/conf

        # background_opacity = "0.85";
        background_blur = 40;

        cursor_shape = "underline";
        cursor_underline_thickness = 1;
        cursor_stop_blinking_after = 0;

        wheel_scroll_multiplier = 12; # font.size;
        remember_window_size = "no";
        window_padding_width = 12 / 3; # font.size / 3;

        modify_font = "underline_position 2";

        confirm_os_window_close = 0;
      };

      theme = null;
    };
  };
}

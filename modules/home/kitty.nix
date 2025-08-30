{
  outputs,
  config,
  ...
}:
outputs.lib.mkConfigModule config false "kitty"
{
  programs.kitty = {
    enable = true;

    keybindings = {};

    settings = {
      # https://sw.kovidgoyal.net/kitty/conf

      background_blur = 20;

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
}

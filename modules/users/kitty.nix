{ pkgs, ... }:

{
  programs.kitty = rec {
    enable = true;

    font = {
      name = "CaskaydiaCove Nerd Font";
      size = 12;
      package = pkgs.nerdfonts.override { fonts = [ "CascadiaCode" ]; };
    };

    keybindings = { };

    settings = {
      # https://sw.kovidgoyal.net/kitty/conf

      cursor_shape = "underline";
      cursor_underline_thickness = 1;
      cursor_stop_blinking_after = 0;

      wheel_scroll_multiplier = font.size;
      remember_window_size = "no";
      window_padding_width = font.size / 4;

      modify_font = "underline_position 2";

      confirm_os_window_close = 0;
    };

    theme = null;
  };
}

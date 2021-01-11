{ pkgs, ... }:

{
  services.xserver = {
    enable = true;

    inherit (import ./lightdm.nix) displayManager;
    inherit (import ./bspwm.nix) windowManager;
  };

  fonts = {
    fonts = with pkgs; [
      # Covers a large portion of the unicode table
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk
      noto-fonts-extra

      # Monospace fonts I like
      jetbrains-mono
      fira-code
      sudo-font
      inconsolata

      # Blocky fonts I like
      undefined-medium
      tewi-font

      # Serif fonts I like
      libertine
      charis-sil

      # Sans fonts I like
      montserrat
      roboto

      # Icon font -- https://www.nerdfonts.com/
      nerdfonts
    ];

    # Fonts futher down the lists are fallbacks
    fontconfig = {
      defaultFonts = {
        serif = [
          "Noto Serif"
          "Linux Libertine"
          "Charis SIL"
        ];
        sansSerif = [
          "Noto Sans"
          "Linux Biolinum"
          "Inconsolata"
        ];
        monospace = [
          "JetBrains Mono"
          "Fira Code"
          "Sudo"
          "Inconsolata"
        ];
        emoji = [
          "Noto Color Emoji"
        ];
      };
    };
  };
}

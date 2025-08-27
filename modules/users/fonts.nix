{pkgs, ...}: let
  fonts = with pkgs; [
    # Writing
    libertine
    atkinson-hyperlegible-next
    noto-fonts

    # Coding
    cascadia-code
    nerd-fonts.caskaydia-cove
    nerd-fonts.caskaydia-mono
  ];
in {
  home.packages = fonts;

  macos.fonts = {
    inherit fonts;
    fontDir.enable = true;
  };
}

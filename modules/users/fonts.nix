{ pkgs, ... }:

let
  fonts = with pkgs; [
    # Writing
    libertine
    atkinson-hyperlegible
    noto-fonts

    # Coding
    cascadia-code
    (nerdfonts.override { fonts = [ "CascadiaCode" "CascadiaMono" ]; })
  ];

in {
  home.packages = fonts;

  macos.fonts = {
    inherit fonts;
    fontDir.enable = true;
  };
}

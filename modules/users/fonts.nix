{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Writing
    libertine
    atkinson-hyperlegible
    noto-fonts

    # Coding
    cascadia-code
    (nerdfonts.override { fonts = [ "CascadiaCode" "CascadiaMono" ]; })
  ];
}

{ pkgs, ... }:

{
  imports = [
    ./fonts.nix # Make sure common fonts are installed
  ];

  home.packages = with pkgs.unstable; [ typst pandoc poppler_utils ];
}

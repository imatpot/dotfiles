{ pkgs, ... }:

{
  imports = [ ./fonts.nix ];

  home.packages = with pkgs.unstable; [ typst pandoc poppler_utils ];
}

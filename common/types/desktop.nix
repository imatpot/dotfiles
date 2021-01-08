{ pkgs, ... }:

{
  imports = [
    ./development.nix
    ../modules/xserver.nix
  ];

  environment.systemPackages = with pkgs; [
    alacritty
    firefox
    chromium
  ];
}

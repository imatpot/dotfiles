{ config, pkgs, ... }:

{
  imports = [
    ../boot.nix
    ../locale.nix
    ../wheel-nopasswd.nix
  ];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_5_9;

  # Do not install optional default packages (e.g. perl)
  environment.defaultPackages = [];

  console.font = "Lat2-Terminus16";

  environment.systemPackages = with pkgs; [
    wget
    vim
    nano
    git
  ];
}

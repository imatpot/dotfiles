{ pkgs, ... }:

{
  imports = [
    ./development.nix

    ../printing.nix
    ../sound.nix

    ../modules/xserver.nix
  ];

  environment.systemPackages = with pkgs; [
    kitty
    firefox-bin
    ungoogled-chromium
  ];
}

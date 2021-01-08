{ config, pkgs, lib, ... }:

let
  home-manager-tar = https://github.com/nix-community/home-manager/tarball/release-20.09;

in

with lib; {
  imports = [
    (import "${builtins.fetchTarball home-manager-tar}/nixos")
  ];

  environment.systemPackages =
    with pkgs;
    mkIf config.services.xserver.enable [
        spotify
        discord
        bitwarden
      ];

  home-manager.users.mladen = {
    home.keyboard.layout = "ch(de_nodeadkeys)";

    xsession = mkIf config.services.xserver.enable
      (import ./modules/xsession.nix).xsession;

    services = {
      sxhkd = mkIf config.services.xserver.enable
        (import ./modules/sxhkd.nix).sxhkd;

      polybar = mkIf config.services.xserver.enable
        (import ./modules/polybar.nix).polybar;
    };

    programs = {
      inherit (import ./modules/git.nix) git;
      inherit (import ./modules/fish.nix) fish;
      inherit (import ./modules/starship.nix) starship;

      rofi = mkIf config.services.xserver.enable
        (import ./modules/rofi.nix).rofi;
    };
  };
}

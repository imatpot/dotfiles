{ config, pkgs, lib, ... }:

let
  home-manager-tar = https://github.com/nix-community/home-manager/tarball/release-20.09;
  polybar = import ./services/polybar.nix { inherit pkgs; };

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
        shutter
      ];

  home-manager.users.mladen = {
    home.keyboard.layout = "ch(de_nodeadkeys)";

    xsession = mkIf config.services.xserver.enable
      (import ./programs/xsession.nix).xsession;

    services = {
      sxhkd = mkIf config.services.xserver.enable
        (import ./services/sxhkd.nix).sxhkd;

      polybar = mkIf config.services.xserver.enable
        polybar.polybar;

      picom = mkIf config.services.xserver.enable
        (import ./services/picom.nix).picom;
    };

    programs = {
      inherit (import ./programs/git.nix) git;
      inherit (import ./programs/fish.nix) fish;
      inherit (import ./programs/starship.nix) starship;

      rofi = mkIf config.services.xserver.enable
        (import ./programs/rofi.nix).rofi;
    };
  };
}

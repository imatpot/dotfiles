{ config, pkgs, lib, ... }:

let
  home-manager = https://github.com/nix-community/home-manager/tarball/release-20.09;
  firefox = import ./programs/firefox.nix { inherit pkgs; };

in
  with lib; {
    imports = [
      (import "${builtins.fetchTarball home-manager}/nixos")
    ];

    environment.systemPackages =
      with pkgs;
      mkIf config.services.xserver.enable
        [
          spotify
          discord
          bitwarden
          shutter
        ];

    services = {
      syncthing = mkIf config.services.xserver.enable (import ./services/syncthing.nix).syncthing;
    };

    home-manager.users.mladen = {
      home.keyboard = {
        layout = "ch";
        variant = "de_nodeadkeys";
      };

      programs = {
        inherit (import ./programs/git.nix) git;
        inherit (import ./programs/fish.nix) fish;
        inherit (import ./programs/starship.nix) starship;

        firefox = mkIf config.services.xserver.enable
          firefox.firefox;
      };
    };
  }

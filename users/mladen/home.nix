{ config, pkgs, lib, ... }:

let
  home-manager = https://github.com/nix-community/home-manager/tarball/release-20.09;
  firefox = import ./programs/firefox.nix { inherit pkgs; };
  npm-tweaks = import ./programs/npm-tweaks.nix;
  gui = config.services.xserver.enable;

in
  with lib; {
    imports = [
      (import "${builtins.fetchTarball home-manager}/nixos")
    ];

    environment.systemPackages =
      with pkgs;
      mkIf gui
        [
          spotify
          discord
          bitwarden
          shutter
          libreoffice
        ];

    services = {
      syncthing = mkIf gui (import ./services/syncthing.nix).syncthing;
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
        inherit (import ./programs/alacritty.nix) alacritty;

        firefox = mkIf gui firefox.firefox;
      };

      home = {
        sessionPath = [ npm-tweaks.path ];

        file = {
          ".npmrc".text = npm-tweaks.npmrc;
        };
      };
    };
  }

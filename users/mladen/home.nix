{ config, pkgs, lib, ... }:

let
  home-manager = https://github.com/nix-community/home-manager/tarball/release-20.09;
  gui = config.services.xserver.enable;

in
  with lib; {
    imports = [
      (import "${builtins.fetchTarball home-manager}/nixos")
    ];

    environment.systemPackages = with pkgs;[
      any-nix-shell
    ] ++ (
      if gui then
        [
          spotify
          discord
          bitwarden

          libreoffice

          shutter
          gimp
          audacity
        ] else []
    );

    services = mkIf gui {
      inherit (import ./services/syncthing.nix) syncthing;
    };

    home-manager.users.mladen = {
      programs = mkMerge [
        {
          inherit (import ./programs/git.nix) git;
          inherit (import ./programs/fish.nix) fish;
          inherit (import ./programs/starship.nix) starship;
        }
        (
          mkIf gui {
            inherit (import ./programs/alacritty.nix) alacritty;
            inherit (import ./programs/firefox.nix { inherit pkgs; }) firefox;
          }
        )
      ];

      home = mkMerge
        [
          {
            keyboard = {
              layout = "ch";
              variant = "de_nodeadkeys";
            };
          }
          (
            let
              npm-tweaks = import ./programs/npm-tweaks.nix;
            in
              {
                sessionPath = [ npm-tweaks.path ];
                file = { ".npmrc".text = npm-tweaks.npmrc; };
              }
          )
        ];
    };
  }

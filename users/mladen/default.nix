{ config, pkgs, lib, ... }:

let
  gui = config.services.xserver.enable;

in
  with lib; {
    # Use latest Discord tarball
    nixpkgs.overlays = [
      (
        self: super: {
          discord = super.discord.overrideAttrs (
            _: {
              src = builtins.fetchTarball https://discord.com/api/download?platform=linux&format=tar.gz;
            }
          );
        }
      )
    ];

    imports = [
      ./home.nix
    ];

    hardware.keyboard.zsa.enable = true;

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
          inkscape
          wally-cli
        ] else []
    );

    services = mkIf gui {
      inherit (import ./services/syncthing.nix) syncthing;
    };

    users.users.mladen = {
      description = "Mladen Brankovic";
      extraGroups = [
        "wheel"
        "video"
        "audio"
        "users"
        "docker"
      ];

      isNormalUser = true;
      createHome = true;

      shell = pkgs.fish; # I like fish. Don't judge me.
    };
  }

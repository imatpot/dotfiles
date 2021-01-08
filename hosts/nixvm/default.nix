{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix

    ../../common/types/server.nix

    ../../users/mladen
  ];

  networking.hostName = "nixvm";

  # Minimal compatibility version, or something like that. Ne need to touch
  # https://nixos.org/manual/nixos/stable/options.html#opt-system.stateVersion
  system.stateVersion = "20.09";
}

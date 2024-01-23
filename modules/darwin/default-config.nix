{ outputs, pkgs, hostname, stateVersion, ... }:

with outputs.lib;

{
  system.stateVersion = mkDefault stateVersion;
  networking.hostName = mkDefault hostname;

  time.timeZone = mkDefault "Europe/Zurich";

  environment.systemPackages = with pkgs; [ vim git wget curl ];

  services.nix-daemon.enable = mkDefault true;

  nix = {
    gc = {
      automatic = mkDefault true;
      options = mkDefault "--delete-older-than 14d";
    };
  };
}

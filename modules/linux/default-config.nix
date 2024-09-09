{ outputs, pkgs, hostname, stateVersion, ... }:

with outputs.lib;

{
  imports = [ ./user-nixos-configs.nix ];

  system.stateVersion = mkDefault stateVersion;
  networking.hostName = mkDefault hostname;

  time.timeZone = mkDefault "Europe/Zurich";
  i18n.defaultLocale = mkDefault "en_GB.UTF-8";
  console.keyMap = mkDefault "sg";
  services.xserver.xkb = {
    layout = mkDefault "ch";
    variant = mkDefault "legacy";
  };

  environment.systemPackages = with pkgs; [ vim git wget curl nmap dots ];

  nix.gc = {
    automatic = mkDefault true;
    dates = mkDefault "weekly";
    options = mkDefault "--delete-older-than 14d";
  };
}

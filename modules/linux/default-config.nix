{ outputs, pkgs, hostname, stateVersion, ... }:

with outputs.lib;

{
  imports = [ ./user-nixos-configs.nix ]
    ++ (concatImports { path = ../../modules/hosts; });

  system.stateVersion = mkDefault stateVersion;
  networking.hostName = mkDefault hostname;
  networking.networkmanager.enable = true;

  time.timeZone = mkDefault "Europe/Zurich";
  i18n.defaultLocale = mkDefault "en_GB.UTF-8";
  console.keyMap = mkDefault "sg";
  services.xserver.xkb.layout = mkDefault "ch";

  environment.systemPackages = with pkgs; [ vim git wget curl nmap dots ];
  environment.enableAllTerminfo = true;

  nix.gc = {
    automatic = mkDefault true;
    dates = mkDefault "weekly";
    options = mkDefault "--delete-older-than 14d";
  };
}

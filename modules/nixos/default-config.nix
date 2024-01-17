{ outputs, ... }:

{ pkgs, hostname, stateVersion, ... }:

with outputs.lib;

{
  system.stateVersion = mkDefault stateVersion;
  networking.hostName = mkDefault hostname;

  time.timeZone = mkDefault "Europe/Zurich";
  i18n.defaultLocale = mkDefault "en_GB.UTF-8";
  console.keyMap = mkDefault "sg";
  services.xserver = {
    layout = mkDefault "ch";
    xkbVariant = mkDefault "legacy";
  };

  environment.systemPackages = mkDefault (with pkgs; [ vim git ]);

  nix.gc = mkDefault {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
}

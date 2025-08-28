{
  inputs,
  outputs,
  pkgs,
  hostname,
  stateVersion,
  ...
}:
with outputs.lib; {
  imports = [./user-nixos-configs.nix] ++ (enumeratePaths {path = /. + "${builtins.unsafeDiscardStringContext inputs.self}/modules/hosts";});

  system.stateVersion = mkDefault stateVersion;
  networking.hostName = mkDefault hostname;
  networking.networkmanager.enable = true;

  time.timeZone = mkDefault "Europe/Zurich";
  i18n.defaultLocale = mkDefault "en_GB.UTF-8";
  console.keyMap = mkDefault "sg";
  services.xserver.xkb.layout = mkDefault "ch";

  environment.enableAllTerminfo = true;
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    nmap
    dots
  ];

  programs.nh = {
    enable = mkDefault true;
    clean = {
      enable = mkDefault true;
      dates = mkDefault "weekly";
      extraArgs = mkDefault "--keep 3 --keep-since-7d";
    };
  };
}

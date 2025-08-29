{
  inputs,
  outputs,
  pkgs,
  hostname,
  stateVersion,
  ...
}:
with outputs.lib; {
  imports =
    [
      "${inputs.self}/lib/modules/macos/user-macos-configs.nix"
    ]
    ++ (enumeratePaths {
      path = "${inputs.self}/modules/macos";
      exclude = [./default-config.nix];
    });

  networking.hostName = mkDefault hostname;

  system = {
    stateVersion = mkDefault stateVersion;

    defaults = {
      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = mkDefault false;
      smb.NetBIOSName = mkDefault hostname;
    };
  };

  time.timeZone = mkDefault "Europe/Zurich";

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    dots
  ];

  services.nix-daemon.enable = mkDefault true;

  nix = {
    gc = {
      automatic = mkDefault true;
      options = mkDefault "--delete-older-than 14d";
    };
  };
}

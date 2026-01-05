{
  inputs,
  outputs,
  pkgs,
  hostname,
  stateVersion,
  config,
  ...
}:
with outputs.lib; {
  imports =
    (enumeratePaths {
      path = "${inputs.self}/lib/modules/nixos";
    })
    ++ (enumeratePaths {
      path = "${inputs.self}/modules/nixos";
      exclude = [./default-config.nix];
    });

  system.stateVersion = mkDefault stateVersion;

  networking = {
    hostName = mkDefault hostname;
    networkmanager.enable = mkDefault true;
  };

  time.timeZone = mkDefault "Europe/Zurich";
  i18n.defaultLocale = mkDefault "en_GB.UTF-8";
  console.keyMap = mkDefault "sg";
  services.xserver.xkb.layout = mkDefault "ch";

  environment = {
    enableAllTerminfo = true;
    systemPackages = with pkgs;
      [
        vim
        git
        wget
        curl
        nmap
        ffmpeg
        # nix-alien
        nixos-firewall-tool
      ]
      ++ outputs.lib.optionals config.modules.gui.enable [
        firefox
        ungoogled-chromium
        vlc
      ];
  };

  systemd = {
    packages = with pkgs; [lact];
    services.lactd.wantedBy = ["multi-user.target"];
  };

  programs.nh = {
    enable = mkDefault true;
    clean = {
      enable = mkDefault true;
      dates = mkDefault "weekly";
      extraArgs = mkDefault "--keep 3 --keep-since-7d";
    };
  };
}

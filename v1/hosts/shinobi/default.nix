{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix

    ../../common/types/desktop.nix

    ../../users/mladen
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "shinobi";

  networking = {
    useDHCP = false;
    interfaces.eno1 = {
      useDHCP = false;

      ipv4.addresses = [
        {
          address = "192.168.1.100";
          prefixLength = 24;
        }
      ];
    };

    defaultGateway = {
      address = "192.168.1.1";
      interface = "eno1";
    };

    networkmanager = {
      enable = true;

      insertNameservers = [
        "192.168.1.69"
        "1.1.1.1"
        "1.0.0.1"
      ];
    };
  };

  services.xserver.videoDrivers = [ "nouveau" ];

  # Mount Samba share from my home server
  fileSystems."/mnt/home-server" = {
    fsType = "cifs";
    device = "//192.168.1.69/share";
    options = [
      "noauto"
      "x-systemd.automount"
      "x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
      "uid=1000"
      "gid=1000"
      "credentials=/home/mladen/smb-secrets"
    ];
  };

  # Minimal compatibility version, or something like that. Ne need to touch
  # https://nixos.org/manual/nixos/stable/options.html#opt-system.stateVersion
  system.stateVersion = "20.09";
}

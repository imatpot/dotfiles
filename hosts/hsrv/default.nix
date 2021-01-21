{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix

    ../../common/types/server.nix
    ../../common/modules/zfs.nix

    ../../users/mladen
  ];

  networking = {
    hostName = "hsrv";
    hostId = "669d3002";

    # Set up static IP
    useDHCP = false;
    interfaces.enp0s31f6 = {
      useDHCP = false;
      ipv4.addresses = [
        {
          address = "192.168.1.69";
          prefixLength = 24;
        }
      ];
    };

    defaultGateway = {
      address = "192.168.1.1";
      interface = "enp0s31f6";
    };

    networkmanager = {
      enable = true;

      insertNameservers = [
        "127.0.0.1" # I usually run a pihole
        "1.1.1.1"
        "1.0.0.1"
      ];
    };
  };

  # Minimal compatibility version. Ne need to touch.
  # https://nixos.org/manual/nixos/stable/options.html#opt-system.stateVersion
  system.stateVersion = "20.09";
}

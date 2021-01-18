{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix

    ../../common/types/server.nix

    ../../users/mladen
  ];

  networking.hostName = "hsrv";

  # Set up a static IP
  networking = {
    useDHCP = false;
    interfaces.eno1 = {
      # TODO: eno1 is likely not the correct name
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
      interface = "eno1"; # TODO: This is likely not the correct name
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

  services.xserver.videoDrivers = [ "nouveau" ];

  # Minimal compatibility version. Ne need to touch.
  # https://nixos.org/manual/nixos/stable/options.html#opt-system.stateVersion
  system.stateVersion = "20.09";
}

{ lib, ... }:

{
  nixos = lib.mkHost {
    system = "x86_64-linux";
    hostname = "nixos";
    stateVersion = "24.05";
    users = [ "mladen" ];
  };
}

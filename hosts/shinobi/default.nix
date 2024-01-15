{ lib, ... }:

{
  shinobi = lib.mkHost {
    system = "x86_64-linux";
    hostname = "shinobi";
    stateVersion = "24.05";
    users = [ "mladen" ];
  };
}

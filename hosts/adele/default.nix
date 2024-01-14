{ lib, ... }:

{
  adele = lib.mkHost {
    system = "x86_64-linux";
    hostname = "adele";
    stateVersion = "24.05";
    users = [ "mladen" ];
  };
}

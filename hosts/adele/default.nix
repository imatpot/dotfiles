{ outputs, ... }:

{
  adele = outputs.lib.mkHost {
    hostname = "adele";
    stateVersion = "24.05";
    users = [ "mladen" ];
  };
}

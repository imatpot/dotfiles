{ outputs, ... }:

{
  shinobi = outputs.lib.mkHost {
    hostname = "shinobi";
    stateVersion = "24.05";
    users = [ "mladen" ];
  };
}

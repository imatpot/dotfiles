{ outputs, ... }:

let
  common = {
    username = "mladen";
    stateVersion = "24.05";
  };

in {
  "mladen" = outputs.lib.mkUser common;

  "mladen@mcdonalds" = outputs.lib.mkUser (common // {
    system = "aarch64-darwin";
    hostname = "mcdonalds";
  });
}

{ outputs, ... }:

let
  common = {
    name = "mladen";
    stateVersion = "23.11";
  };

in {
  "mladen" = outputs.lib.mkUser common;

  "mladen@mcdonalds" = outputs.lib.mkUser (common // {
    system = "aarch64-darwin";
    hostname = "mcdonalds";
  });
}

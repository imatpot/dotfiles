{ lib, ... }:

let
  common = {
    username = "mladen";
    stateVersion = "24.05";
  };

in {
  "mladen" = lib.mkUser common;

  "mladen@mcdonalds" = lib.mkUser (common // {
    system = "aarch64-darwin";
    hostname = "mcdonalds";
  });
}

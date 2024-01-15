{ lib, ... }:

{
  nixpkgs = {
    config = lib.nixpkgsDefaultConfig;
    overlays = lib.nixpkgsDefaultOverlays;
  };
}

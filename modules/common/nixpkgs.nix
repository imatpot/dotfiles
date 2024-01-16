{ outputs, ... }:

{
  nixpkgs = {
    config = outputs.lib.nixpkgsDefaultConfig;
    overlays = outputs.lib.nixpkgsDefaultOverlays;
  };
}

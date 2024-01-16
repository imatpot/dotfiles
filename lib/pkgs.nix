{ inputs, outputs, ... }:

rec {
  nixpkgsDefaultConfig = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: true;
  };

  nixpkgsDefaultOverlays =
    [ outputs.overlays.nixpkgs.unstable outputs.overlays.nixpkgs.nur ];

  pkgsForSystem = system: import inputs.nixpkgs { inherit system; };

  forEachSystem = systems: fn:
    outputs.lib.genAttrs systems (system: fn (pkgsForSystem system));
}

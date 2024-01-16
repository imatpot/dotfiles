{ inputs, outputs, ... }:

rec {
  nixpkgsDefaultConfig = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: true;
  };

  nixpkgsDefaultOverlays = let
    overlayArgs = {
      inherit inputs;
      outputs = outputs // { lib = { inherit nixpkgsDefaultConfig; }; };
    };
  in [
    (import ../overlays/nixpkgs/unstable.nix overlayArgs)
    (import ../overlays/nixpkgs/nur.nix overlayArgs)
  ];

  pkgsForSystem = system: import inputs.nixpkgs { inherit system; };

  forEachSystem = systems: fn:
    outputs.lib.genAttrs systems (system: fn (pkgsForSystem system));
}

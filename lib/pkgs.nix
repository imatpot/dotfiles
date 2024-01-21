flake@{ inputs, outputs, ... }:

rec {
  nixpkgsDefaultConfig = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  nixpkgsDefaultOverlays = [
    (import ../overlays/nixpkgs/unstable.nix flake)
    (import ../overlays/nixpkgs/nur.nix flake)
  ];

  pkgsForSystem = system:
    import inputs.nixpkgs {
      inherit system;
      config = nixpkgsDefaultConfig;
      overlays = nixpkgsDefaultOverlays;
    };

  forEachSystem = systems: fn:
    outputs.lib.genAttrs systems (system: fn (pkgsForSystem system));
}

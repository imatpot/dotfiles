{ inputs, ... }:

rec {
  pkgsForSystem = system: import inputs.nixpkgs { inherit system; };

  forEachSystem = systems: fn:
    inputs.nixpkgs.lib.genAttrs systems (system: fn (pkgsForSystem system));
}

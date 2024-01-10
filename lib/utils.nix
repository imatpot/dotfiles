{ inputs, ... }:

rec {
  systemPkgs = systems:
    inputs.nixpkgs.lib.genAttrs systems
    (system: import inputs.nixpkgs { inherit system; });

  forEachSystem = systems: fn:
    let pkgs = systemPkgs systems;
    in inputs.nixpkgs.lib.genAttrs systems (system: fn pkgs.${system});
}

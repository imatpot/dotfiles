{ inputs, ... }:

rec {
  systemPkgs = systems:
    inputs.nixpkgs.lib.genAttrs systems
    (system: import inputs.nixpkgs { inherit system; });

  withEachSystemPkgs = systems: fn:
    let pkgs = systemPkgs systems;
    in inputs.nixpkgs.lib.genAttrs systems (system: fn pkgs.${system});
}

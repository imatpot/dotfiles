flake @ {inputs, ...}: let
  core = import ./core.nix {
    inherit inputs;
    extlib = with inputs; nix-darwin.lib // home-manager.lib // nixpkgs.lib;
  };
in
  core.deepMerge [
    inputs.nixpkgs.lib
    inputs.nix-darwin.lib
    inputs.home-manager.lib

    core

    (core.importPaths {
      args = flake;
      path = ./.;
      preferDefaultNixFile = false;
      exclude = [./default.nix ./core.nix];
    })
  ]

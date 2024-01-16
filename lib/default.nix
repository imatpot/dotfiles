# Let's build the flake's lib with the correct dependency tree

{ inputs, outputs, ... }:

let
  core = import ./core.nix {
    inherit inputs;
    extlib = inputs.nixpkgs.lib.extend (_: _: inputs.home-manager.lib);
  };

in core.deepMerge [
  inputs.nixpkgs.lib
  inputs.home-manager.lib

  core

  (core.importAndMerge [
    ./systems.nix
    ./pkgs.nix
    ./secrets.nix
    ./users.nix
    ./hosts.nix
  ] { inherit inputs outputs; })
]

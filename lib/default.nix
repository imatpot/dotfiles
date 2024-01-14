{ inputs, ... }:

let
  primitiveUtils = import ./utils.nix {
    inherit inputs;
    lib = inputs.nixpkgs.lib;
  };

  lib = primitiveUtils.importAndMerge [
    ./utils.nix
    ./systems.nix
    ./hosts.nix
    ./users.nix
  ] rec {
    inherit inputs;
    lib = import ./. { inherit inputs; };

    # TODO: Find a way to avoid NixOS & Home Manager generated libs from overriding this in modules
    lib' = lib;
  };

in primitiveUtils.mergeAttrs [ inputs.nixpkgs.lib inputs.home-manager.lib lib ]

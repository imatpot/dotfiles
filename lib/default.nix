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
  ] {
    inherit inputs;
    lib = import ./. { inherit inputs; };
  };

in primitiveUtils.mergeAttrs [ inputs.nixpkgs.lib inputs.home-manager.lib lib ]

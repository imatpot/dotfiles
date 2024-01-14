{ inputs, outputs, ... }:

let
  utils = import ./utils.nix { inherit inputs outputs; };

  lib = utils.importAndMerge [ ./systems.nix ./hosts.nix ./users.nix ] {
    inherit inputs outputs;
  };

in utils.mergeAttrs [ inputs.nixpkgs.lib inputs.home-manager.lib utils lib ]

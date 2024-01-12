{ inputs, ... }:

let
  importer = import ./importer.nix { };

  self = importer.importAndMerge [
    ./utils.nix
    ./importer.nix
    ./systems.nix
    ./hosts.nix
    ./users.nix
  ] {
    inherit inputs;
    lib = import ./. { inherit inputs; };
  };

in inputs.nixpkgs.lib // inputs.home-manager.lib // self

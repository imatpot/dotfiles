{ inputs, ... }:

let
  importAndMerge = files: args:
    if (files == [ ]) then
      { }
    else
      importAndMerge (builtins.tail files) args
      // import (builtins.head files) args;

  externalLibs = inputs.nixpkgs.lib // inputs.home-manager.lib;

  localLibs = importAndMerge [ ./utils.nix ./hosts.nix ./users.nix ] {
    inherit inputs;
    lib = import ./. { inherit inputs; };
  };

in externalLibs // localLibs // { inherit importAndMerge; }

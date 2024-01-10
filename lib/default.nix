{ inputs, ... }:

let
  importAndMerge = files:
    if (files == [ ]) then {
      inherit importAndMerge;
    } else
      import (builtins.head files) { inherit inputs; }
      // importAndMerge (builtins.tail files);

in importAndMerge [ ./makers.nix ./rebuilders.nix ./utils.nix ]

flake@{ outputs, ... }:

outputs.lib.importAndMerge [ ./unstable.nix ./nur.nix ] flake

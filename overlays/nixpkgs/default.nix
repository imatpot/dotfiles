{ inputs, outputs, ... }:

outputs.lib.importAndMerge [ ./unstable.nix ./nur.nix ] {
  inherit inputs outputs;
}

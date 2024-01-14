{ inputs, outputs, ... }:

outputs.lib.importAndMerge [ ./adele ./shinobi ] { inherit inputs outputs; }

flake@{ outputs, ... }:

outputs.lib.importAndMerge [ ./adele ./shinobi ] flake

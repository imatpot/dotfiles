{ outputs, ... }:

outputs.lib.importAndMerge [ ./adele ./shinobi ] { inherit outputs; }

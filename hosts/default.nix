{ lib, inputs, ... }:

lib.importAndMerge [ ./adele ./shinobi ] { inherit lib inputs; }

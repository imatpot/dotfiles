{ lib, ... }:

lib.importAndMerge [ ./adele ./shinobi ] { inherit lib; }

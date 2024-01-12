{ lib, ... }:

lib.importAndMerge [ ./nixos ] { inherit lib; }

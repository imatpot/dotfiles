{ lib, inputs, ... }:

lib.importAndMerge [ ./nixos ] { inherit lib inputs; }

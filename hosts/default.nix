{ lib, inputs, ... }:

lib.importAndMerge [ ./adele ] { inherit lib inputs; }

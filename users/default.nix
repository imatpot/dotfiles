{ lib, inputs, ... }:

lib.importAndMerge [ ./mladen ] { inherit lib inputs; }

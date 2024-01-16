{ outputs, ... }:

outputs.lib.importAndMerge [ ./mladen ] { inherit outputs; }

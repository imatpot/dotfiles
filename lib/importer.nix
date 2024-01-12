{ ... }:

rec {
  importAndMerge = files: args:
    if (files == [ ]) then
      { }
    else
      importAndMerge (builtins.tail files) args
      // import (builtins.head files) args;
}

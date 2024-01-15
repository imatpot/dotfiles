{ lib, inputs, ... }:

rec {
  # Merges a list of attributes into one, including lists and nested attributes.
  # Use this instead of lib.mkMerge if the merge type isn't allowed somewhere.
  # https://stackoverflow.com/a/54505212
  fuseAttrs = attrs:
    let
      merge = path:
        lib.zipAttrsWith (n: values:
          if builtins.tail values == [ ] then
            builtins.head values
          else if builtins.all builtins.isList values then
            lib.unique (inputs.nixpkgs.lib.concatLists values)
          else if builtins.all builtins.isAttrs values then
            merge (path ++ [ n ]) values
          else
            lib.last values);
    in merge [ ] attrs;

  # Imports and merges all modules in a path's module's `imports` recursively.
  # Use this in case you want to resolve modules somewhere they're not, or if
  # you don't want the default merge behavior.
  resolveImports = file: args:
    let module = import file args;
    in if module ? imports then
      fuseAttrs ([ module ]
        ++ (builtins.map (submodule: resolveImports submodule args)
          module.imports))
    else
      module;

  # Imports and merges a list of module paths.
  importAndMerge = files: args:
    let modules = builtins.map (file: import file args) files;
    in fuseAttrs modules;
}

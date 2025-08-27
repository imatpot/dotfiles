# This is the very core of the lib.
# IT MUST ONLY DEPEND ON ITSELF OR EXTERNAL LIBS TO AVOID INFINITE RECURSION.
{
  extlib,
  inputs,
  ...
}: rec {
  # Overrides nixpkgs.lib.types.attrs to be deep-mergible. This avoids configs
  # from mistakenly overriding values due to the use of `//`.
  types.attrs.merge = _: definitions: let
    values = builtins.map (definition: definition.value) definitions;
  in
    deepMerge values;

  # Merges a list of attributes into one, including lists and nested attributes.
  # Use this instead of lib.mkMerge if the merge type isn't allowed somewhere.
  # https://stackoverflow.com/a/54505212
  deepMerge = attrs: let
    merge = path:
      builtins.zipAttrsWith (
        n: values:
          if builtins.tail values == []
          then builtins.head values
          else if builtins.all builtins.isList values
          then extlib.unique (inputs.nixpkgs.lib.concatLists values)
          else if builtins.all builtins.isAttrs values
          then merge (path ++ [n]) values
          else extlib.last values
      );
  in
    merge [] attrs;

  # Imports and merges a list of module paths.
  importPaths = {
    args ? {},
    path ? null,
    paths ? [],
    include ? [],
    exclude ? [],
    recursive ? true,
    preferDefaultNixFile ? true,
  }: let
    modules = builtins.map (file: import file args) (enumeratePaths {
      inherit
        path
        paths
        include
        exclude
        recursive
        preferDefaultNixFile
        ;
    });
  in
    deepMerge modules;

  # Concatinatinates all file paths in a given directory into one list.
  enumeratePaths = {
    path ? null,
    paths ? [],
    include ? [],
    exclude ? [],
    recursive ? true,
    preferDefaultNixFile ? true,
  }:
    with extlib;
    with fileset; let
      excludedFiles = filter (path: pathIsRegularFile path) exclude;
      excludedDirs = filter (path: pathIsDirectory path) exclude;
      isExcluded = path:
        if elem path excludedFiles
        then true
        else (filter (excludedDir: outputs.lib.path.hasPrefix excludedDir path) excludedDirs) != [];

      myFiles = unique (
        (
          filter
          (file: pathIsRegularFile file && hasSuffix ".nix" (builtins.toString file) && !isExcluded file)
          (
            concatMap (
              _path:
                if recursive
                then toList _path
                else
                  mapAttrsToList (
                    name: type:
                      _path
                      + (
                        if type == "directory"
                        then "/${name}/default.nix"
                        else "/${name}"
                      )
                  ) (builtins.readDir _path)
            ) (unique (
              if path == null
              then paths
              else [path] ++ paths
            ))
          )
        )
        ++ (
          if recursive
          then concatMap (path: toList path) (unique include)
          else unique include
        )
      );

      dirOfFile = builtins.map (file: builtins.dirOf file) myFiles;

      dirsWithDefaultNix = builtins.filter (dir: builtins.elem dir dirOfFile) (
        builtins.map (file: builtins.dirOf file) (
          builtins.filter (file: builtins.match "default.nix" (builtins.baseNameOf file) != null) myFiles
        )
      );

      filteredFiles =
        builtins.filter (
          file:
            builtins.elem (builtins.dirOf file) dirsWithDefaultNix
            == false
            || builtins.match "default.nix" (builtins.baseNameOf file) != null
        )
        myFiles;
    in
      if preferDefaultNixFile
      then filteredFiles
      else myFiles;
}

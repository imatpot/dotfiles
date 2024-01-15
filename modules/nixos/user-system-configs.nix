{ lib, system, hostname, stateVersion, users ? [ ], ... }:

let
  allUserConfigs = lib.genAttrs users
    (username: lib.mkUser { inherit username system hostname stateVersion; });

  allSystemConfigs =
    builtins.mapAttrs (username: module: module.config.system) allUserConfigs;

  getSystemConfig = username:
    if allSystemConfigs ? "${username}@${hostname}" then
      allSystemConfigs."${username}@${hostname}"
    else
      allSystemConfigs.${username};

  requiredSystemConfigs = builtins.map getSystemConfig users;

in lib.fuseAttrs requiredSystemConfigs

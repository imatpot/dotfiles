{ system, outputs, hostname, stateVersion, users ? [ ], ... }:

let
  getSystemConfig = username:
    let
      user =
        outputs.lib.mkUser { inherit username system hostname stateVersion; };
    in user.config.system;

  systemConfigs = builtins.map getSystemConfig users;

in outputs.lib.deepMerge systemConfigs

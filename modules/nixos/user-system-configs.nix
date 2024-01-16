{ outputs, ... }:

args@{ system, users ? [ ], ... }:

let
  getSystemConfig = username:
    let user = outputs.lib.mkUser (args // { inherit username; });
    in user.config.system;

  systemConfigs = builtins.map getSystemConfig users;

in outputs.lib.deepMerge systemConfigs

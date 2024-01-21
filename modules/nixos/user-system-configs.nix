args@{ outputs, users, ... }:

let
  userConfigs = builtins.map (name:
    outputs.lib.mkUser {
      inherit name;
      inherit (args) system hostname stateVersion;
    }) users;

  systemConfigs = builtins.map (user: user.config.system) userConfigs;

in outputs.lib.deepMerge systemConfigs

args@{ outputs, users, ... }:

let
  userConfigs = builtins.map (username:
    outputs.lib.mkUser {
      inherit username;
      inherit (args) system hostname stateVersion;
    }) users;

  darwinConfigs = builtins.map (user: user.config.darwin) userConfigs;

in outputs.lib.deepMerge darwinConfigs

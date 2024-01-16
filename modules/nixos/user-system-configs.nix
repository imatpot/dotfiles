{ outputs, ... }:
args@{ system, hostname, stateVersion, users ? [ ], ... }:

let
  # https://nixos.wiki/wiki/Nix_Language_Quirks#Default_values_are_not_bound_in_.40_syntax
  args' = args // { inherit users; };

  getSystemConfig = username:
    let user = outputs.lib.mkUser (args' // { inherit username; });
    in user.config.system;

  systemConfigs = builtins.map getSystemConfig users;

in outputs.lib.deepMerge systemConfigs

{ lib, system, hostname, stateVersion, users ? [ ], ... }:

let
  getSystemConfig = username:
    let user = lib.mkUser { inherit username system hostname stateVersion; };
    in user.config.system;

  systemConfigs = builtins.map getSystemConfig users;

in lib.fuseAttrs systemConfigs

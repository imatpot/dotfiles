{ lib, lib', inputs, hostname, system, stateVersion, users ? [ ], ... }:

let
  userConfigs = lib.genAttrs users (username:
    lib.resolveImports ../../users/${username}/home.nix {
      inherit lib' inputs hostname system stateVersion;
    });

  userDefinedSystemConfig = lib.mergeAttrs
    (builtins.map (userConfig: userConfig.system)
      (builtins.attrValues userConfigs));

  homeManager = {
    home-manager = {
      users = userConfigs;

      sharedModules = [ ../home-manager/system-config-support.nix ];

      # https://discourse.nixos.org/t/home-manager-useuserpackages-useglobalpkgs-settings/34506/4
      useGlobalPkgs = false;
      useUserPackages = false;
    };
  };

in lib.mergeAttrs [ userDefinedSystemConfig homeManager ]

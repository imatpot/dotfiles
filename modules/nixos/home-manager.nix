{ inputs, outputs, hostname, system, stateVersion, users ? [ ], ... }:

let
  userConfigs = outputs.lib.genAttrs users (username:
    outputs.lib.resolveImports ../../users/${username}/home.nix {
      inherit inputs outputs hostname system stateVersion;
    });

  userDefinedSystemConfig = outputs.lib.mergeAttrs
    (builtins.map (userConfig: userConfig.system)
      (builtins.attrValues userConfigs));

  homeManager = {
    home-manager = {
      users = userConfigs;

      extraSpecialArgs = { inherit outputs; };
      sharedModules = [ ../home-manager/system-config-support.nix ];

      # https://discourse.nixos.org/t/home-manager-useuserpackages-useglobalpkgs-settings/34506/4
      useGlobalPkgs = false;
      useUserPackages = false;
    };
  };

in outputs.lib.mergeAttrs [ userDefinedSystemConfig homeManager ]

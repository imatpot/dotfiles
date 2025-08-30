args @ {
  inputs,
  outputs,
  system,
  hostname,
  users,
  stateVersion,
  ...
}: let
  # Nix-Darwin does this funny thing where its own state version is an
  # integer, but Home Manager's is a string (like it should)
  stateVersion' =
    if outputs.lib.isDarwin system
    then outputs.lib.defaultStateVersion
    else stateVersion;
in
  outputs.lib.mkFor system hostname {
    systems = {
      linux.imports = [inputs.home-manager.nixosModules.home-manager];
      darwin.imports = [inputs.home-manager.darwinModules.home-manager];
    };

    common.home-manager = {
      users = outputs.lib.genAttrs users (username: {
        # Submodules only pass `name`, but I want `username` as well
        _module.args.username = username;

        imports = outputs.lib.enumeratePaths {
          path = "${inputs.self}/users/${username}";
        };
      });

      extraSpecialArgs = {
        stateVersion = stateVersion';

        # The `config` passed from NixOS would override Home Manager's `config`,
        # so we re-expose every attribute except `config`.
        # https://github.com/nix-community/home-manager/blob/ca4126e3c568be23a0981c4d69aed078486c5fce/nixos/common.nix#L20
        inherit
          (args)
          inputs
          outputs
          system
          hostname
          users
          ;
      };

      sharedModules = [
        outputs.lib.mkHomeManagerCoreModules
      ];

      # Prevents NixOS & Darwin & non-NixOS user configurations from diverging.
      # https://discourse.nixos.org/t/home-manager-useuserpackages-useglobalpkgs-settings/34506/4
      useGlobalPkgs = false;
      useUserPackages = false;
    };
  }

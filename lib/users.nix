flake @ {
  inputs,
  outputs,
  ...
}: {
  mkUser = with outputs.lib;
    args @ {
      username,
      hostname ? null,
      system ? "x86_64-linux",
      stateVersion ? defaultStateVersion,
      osConfig ? null,
      ...
    }:
      homeManagerConfiguration {
        pkgs = pkgsForSystem system;

        extraSpecialArgs =
          flake
          // args
          // {
            # https://nixos.wiki/wiki/Nix_Language_Quirks#Default_values_are_not_bound_in_.40_syntax
            inherit
              system
              hostname
              stateVersion
              osConfig
              username
              ;

            # Actual name required by submodules. This makes sure everything is
            # interopable across NixOS & non-NixOS systems.
            # https://github.com/nix-community/home-manager/blob/ca4126e3c568be23a0981c4d69aed078486c5fce/nixos/common.nix#L22
            name = username;
            users = [username];
          };

        modules = [
          outputs.lib.mkHomeManagerCoreModules
          "${inputs.self}/users/${username}/home.nix"

          # Standalone-only, to not override the system's config
          "${inputs.self}/modules/nix/nix.nix"

          # Standalone-only, as it's incompatible with stylix.nixosModules.stylix
          # https://github.com/nix-community/stylix/issues/1719
          inputs.stylix.homeModules.stylix
        ];
      };

  mkHomeManagerCoreModules = {system, ...}: {
    imports =
      outputs.lib.enumeratePaths {
        path = "${inputs.self}/modules/users";
      }
      ++ [
        "${inputs.self}/modules/nix/nixpkgs.nix"
        "${inputs.self}/lib/modules/home-manager/system-config-support.nix"
        inputs.sops-nix.homeManagerModules.sops
        inputs.vault.homeModules.default
        inputs.nix-index-database.homeModules.nix-index
      ]
      ++ outputs.lib.optionals (outputs.lib.isDarwin system) [
        # TODO: Check back later if it compiles again
        # inputs.mac-app-util.homeManagerModules.default
      ];
  };
}

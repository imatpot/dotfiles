{ lib, inputs, ... }:

{
  importAllHosts = import ../hosts { inherit lib; };

  mkHost = { hostname, system, stateVersion, users ? [ ] }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ../hosts/${hostname}/configuration.nix
        ../hosts/${hostname}/hardware.nix

        inputs.home-manager.nixosModules.home-manager

        {
          home-manager = {
            users = lib.genAttrs users (user: import ../users/${user}/home.nix);

            extraSpecialArgs = {
              inherit inputs hostname system stateVersion;
              lib' = lib; # TODO: Merge with lib passed from home-manager itself
            };

            # https://discourse.nixos.org/t/home-manager-useuserpackages-useglobalpkgs-settings/34506/4
            useGlobalPkgs = false;
            useUserPackages = false;
          };
        }
      ];
    };
}

{ inputs, outputs, ... }:

{
  mkHost = { hostname, system, stateVersion, users ? [ ] }:
    let
      homeManagerConfig = import ../modules/nixos/home-manager.nix {
        inherit inputs outputs hostname system stateVersion users;
      };
    in outputs.lib.nixosSystem {
      inherit system;

      modules = [
        {
          _module.args = {
            inherit inputs outputs hostname system stateVersion;
          };
        }

        ../hosts/${hostname}/configuration.nix
        ../hosts/${hostname}/hardware.nix

        inputs.home-manager.nixosModules.home-manager
        homeManagerConfig
      ];
    };
}

{ inputs, outputs, ... }:

{
  mkHost = { hostname, system, stateVersion, users ? [ ] }:
    outputs.lib.nixosSystem {
      inherit system;

      modules = [
        {
          _module.args = {
            inherit inputs outputs hostname system stateVersion users;
          };
        }

        ../hosts/${hostname}/configuration.nix
        ../hosts/${hostname}/hardware.nix

        inputs.home-manager.nixosModules.home-manager
        ../modules/nixos/home-manager.nix
      ];
    };
}

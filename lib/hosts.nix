{ inputs, outputs, ... }:

{
  mkHost = { hostname, system, stateVersion, users ? [ ] }:
    outputs.lib.nixosSystem {
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
        inputs.sops-nix.nixosModules.sops

        outputs.commonModules.nixpkgs

        (outputs.nixosModules.homeManager {
          inherit system hostname stateVersion users;
        })

        (outputs.nixosModules.userSystemConfigs {
          inherit system hostname stateVersion users;
        })
      ];
    };
}

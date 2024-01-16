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

        (import ../modules/common/nixpkgs.nix { inherit outputs; })

        (import ../modules/nixos/home-manager.nix {
          inherit inputs outputs hostname system stateVersion users;
        })

        (import ../modules/nixos/user-system-configs.nix {
          inherit outputs hostname system stateVersion users;
        })
      ];
    };
}

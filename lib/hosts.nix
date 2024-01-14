{ lib, inputs, ... }:

{
  importAllHosts = import ../hosts { inherit lib; };

  mkHost = { hostname, system, stateVersion, users ? [ ] }:
    let
      homeManagerConfig = import ../modules/nixos/home-manager.nix {
        inherit lib inputs hostname system stateVersion users;
        lib' = lib;
      };
    in inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ../hosts/${hostname}/configuration.nix
        ../hosts/${hostname}/hardware.nix

        inputs.home-manager.nixosModules.home-manager
        homeManagerConfig
      ];
    };
}

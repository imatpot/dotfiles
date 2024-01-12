{ lib, inputs, ... }:

{
  importAllHosts = import ../hosts { inherit lib; };

  mkHost = { hostname, system, stateVersion, users ? [ ], }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ../hosts/${hostname}/configuration.nix
        inputs.home-manager.nixosModules.home-manager
      ];
    };
}

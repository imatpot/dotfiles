{ inputs, ... }:

{
  mkUser = { username }: { };

  mkHost = { hostname, system, stateVersion, users ? [ ], }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        ../hosts/${hostname}
        inputs.home-manager.nixosModules.home-manager
      ];
    };
}

flake@{ inputs, outputs, ... }:

{
  mkHost = args@{ hostname, system, users ? [ ], ... }:
    let
      # https://nixos.wiki/wiki/Nix_Language_Quirks#Default_values_are_not_bound_in_.40_syntax
      args' = args // { inherit users; };
    in outputs.lib.nixosSystem {
      inherit system;

      modules = [
        { _module.args = flake // args'; }

        ../hosts/${hostname}/configuration.nix
        ../hosts/${hostname}/hardware.nix

        inputs.home-manager.nixosModules.home-manager
        inputs.sops-nix.nixosModules.sops

        outputs.commonModules.nixpkgs

        (outputs.nixosModules.homeManager args')
        (outputs.nixosModules.userSystemConfigs args')
      ];
    };
}

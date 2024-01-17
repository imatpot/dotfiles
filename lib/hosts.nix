flake@{ inputs, outputs, ... }:

{
  mkHost = args@{ hostname, system, stateVersion, users ? [ ], ... }:
    let
      pkgs = outputs.lib.pkgsForSystem system;
      # https://nixos.wiki/wiki/Nix_Language_Quirks#Default_values_are_not_bound_in_.40_syntax
      args' = args // { inherit users; };
      pkgsArgs = args' // { inherit pkgs; };

    in outputs.lib.nixosSystem {
      inherit system;

      modules = [
        { _module.args = flake // args'; }

        ../hosts/${hostname}/configuration.nix
        ../hosts/${hostname}/hardware.nix

        inputs.home-manager.nixosModules.home-manager
        inputs.sops-nix.nixosModules.sops

        (outputs.commonModules.nix pkgs)
        outputs.commonModules.nixpkgs

        (outputs.nixosModules.defaultConfig pkgsArgs)
        (outputs.nixosModules.homeManager pkgsArgs)
        (outputs.nixosModules.userSystemConfigs args')
        outputs.nixosModules.nixLegacyConsistency
      ];
    };
}

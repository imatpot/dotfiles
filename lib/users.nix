flake@{ inputs, outputs, ... }:

{
  mkUser = args@{ username, stateVersion, system ? "x86_64-linux"
    , hostname ? null, ... }:
    let
      # https://nixos.wiki/wiki/Nix_Language_Quirks#Default_values_are_not_bound_in_.40_syntax
      args' = args // { inherit system hostname; };
    in outputs.lib.homeManagerConfiguration {
      pkgs = outputs.lib.pkgsForSystem system;

      extraSpecialArgs = flake // args';

      modules = [
        ../users/${username}/home.nix

        inputs.sops-nix.homeManagerModules.sops

        outputs.commonModules.nixpkgs
        outputs.homeManagerModules.systemConfigSupport
      ];
    };
}

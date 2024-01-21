flake@{ inputs, outputs, ... }:

{
  mkUser =
    args@{ name, stateVersion, system ? "x86_64-linux", hostname ? null, ... }:
    let
      pkgs = outputs.lib.pkgsForSystem system;
      # https://nixos.wiki/wiki/Nix_Language_Quirks#Default_values_are_not_bound_in_.40_syntax
      args' = args // {
        inherit system hostname;

        # mkUser generates pure, system-agnostic Home Manager configurations.
        osConfig = null;
      };

    in outputs.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = flake // args';

      modules = [
        inputs.sops-nix.homeManagerModules.sops

        ../users/${name}/home.nix

        ../modules/common/nix.nix
        ../modules/common/nixpkgs.nix

        ../modules/home-manager/system-config-support.nix
        ../modules/home-manager/default-config.nix
      ];
    };
}

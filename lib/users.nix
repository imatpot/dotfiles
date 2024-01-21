flake@{ inputs, outputs, ... }:

{
  mkUser = args@{ username, stateVersion, system ? "x86_64-linux"
    , hostname ? null, ... }:
    outputs.lib.homeManagerConfiguration {
      pkgs = outputs.lib.pkgsForSystem system;

      extraSpecialArgs = flake // args // {
        # https://nixos.wiki/wiki/Nix_Language_Quirks#Default_values_are_not_bound_in_.40_syntax
        inherit system hostname;

        # `mkUser` should generate pure, system-agnostic Home Manager configs.
        # https://github.com/nix-community/home-manager/blob/ca4126e3c568be23a0981c4d69aed078486c5fce/nixos/common.nix#L18
        osConfig = null;

        # Actual name required by submodules. This makes sure everything is
        # interopable across NixOS & non-NixOS systems.
        # https://github.com/nix-community/home-manager/blob/ca4126e3c568be23a0981c4d69aed078486c5fce/nixos/common.nix#L22
        name = username;
      };

      modules = [
        inputs.sops-nix.homeManagerModules.sops

        ../users/${username}/home.nix

        ../modules/common/nix.nix
        ../modules/common/nixpkgs.nix

        ../modules/home-manager/system-config-support.nix
        ../modules/home-manager/default-config.nix
      ];
    };
}

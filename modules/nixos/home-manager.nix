flake@{ inputs, outputs, ... }:
args@{ hostname, system, stateVersion, users ? [ ], ... }:

let
  # https://nixos.wiki/wiki/Nix_Language_Quirks#Default_values_are_not_bound_in_.40_syntax
  args' = args // { inherit users; };
in {
  home-manager = {
    users = outputs.lib.genAttrs users
      (username: import ../../users/${username}/home.nix);

    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
      outputs.commonModules.nixpkgs
      outputs.homeManagerModules.systemConfigSupport
    ];

    extraSpecialArgs = flake // args';

    # https://discourse.nixos.org/t/home-manager-useuserpackages-useglobalpkgs-settings/34506/4
    useGlobalPkgs = false;
    useUserPackages = false;
  };
}

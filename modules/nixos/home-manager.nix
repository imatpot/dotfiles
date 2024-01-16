flake@{ inputs, outputs, ... }:

args@{ users ? [ ], ... }:

{
  home-manager = {
    users = outputs.lib.genAttrs users
      (username: import ../../users/${username}/home.nix);

    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
      outputs.commonModules.nixpkgs
      outputs.homeManagerModules.systemConfigSupport
    ];

    extraSpecialArgs = flake // args;

    # https://discourse.nixos.org/t/home-manager-useuserpackages-useglobalpkgs-settings/34506/4
    useGlobalPkgs = false;
    useUserPackages = false;
  };
}

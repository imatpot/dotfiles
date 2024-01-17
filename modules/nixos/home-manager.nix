flake@{ inputs, outputs, ... }:

args@{ users ? [ ], ... }:

let
  mkUserConfig = username: args':
    outputs.lib.deepMerge [
      (outputs.homeManagerModules.defaultConfig (args // { inherit username; }))
      (import ../../users/${username}/home.nix args')
    ];

in {
  home-manager = {
    users = outputs.lib.genAttrs users mkUserConfig;

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

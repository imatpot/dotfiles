{ inputs, outputs, hostname, system, stateVersion, users ? [ ], ... }:

{
  home-manager = {
    users = outputs.lib.genAttrs users
      (username: import ../../users/${username}/home.nix);

    sharedModules = [
      inputs.sops-nix.homeManagerModules.sops
      (import ../common/nixpkgs.nix { inherit outputs; })
      (import ../home-manager/system-config-support.nix { inherit outputs; })
    ];

    extraSpecialArgs = { inherit inputs outputs system hostname stateVersion; };

    # https://discourse.nixos.org/t/home-manager-useuserpackages-useglobalpkgs-settings/34506/4
    useGlobalPkgs = false;
    useUserPackages = false;
  };
}

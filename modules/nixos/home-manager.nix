{ lib, hostname, system, stateVersion, users ? [ ], ... }:

{
  home-manager = {
    users = lib.genAttrs users (username:
      (lib.mkUser { inherit username hostname system stateVersion; }).config);

    sharedModules =
      [ (import ../home-manager/system-config-support.nix { inherit lib; }) ];

    # https://discourse.nixos.org/t/home-manager-useuserpackages-useglobalpkgs-settings/34506/4
    useGlobalPkgs = false;
    useUserPackages = false;
  };
}

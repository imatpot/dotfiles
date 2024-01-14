{ lib, inputs, ... }:

{
  mkUser = { username, stateVersion, system ? "x86_64-linux", hostname ? null }:
    let
      userConfig = lib.resolveImports ../users/${username}/home.nix {
        inherit lib inputs username system hostname stateVersion;
      };
    in lib.homeManagerConfiguration {
      pkgs = lib.pkgsForSystem system;
      modules =
        [ ../modules/home-manager/system-config-support.nix userConfig ];
    };
}

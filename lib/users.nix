{ lib, lib', inputs, ... }:

{
  importAllUsers = import ../users { inherit lib inputs; };

  mkUser = { username, stateVersion, system ? "x86_64-linux", hostname ? null }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = lib.pkgsForSystem system;
      extraSpecialArgs = { inherit lib' system hostname stateVersion; };
      modules = [
        ../modules/home-manager/system-config-support.nix
        ../users/${username}/home.nix
      ];
    };
}

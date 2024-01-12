{ lib, inputs, ... }:

{
  importAllUsers = import ../users { inherit lib inputs; };

  mkUser = { username, stateVersion, system ? "x86_64-linux", hostname ? null }:
    let
      home = import ../users/${username}/home.nix {
        inherit system hostname stateVersion;
        lib' = lib; # TODO: Fix conflict with home-manager generated lib
      };
    in inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = lib.pkgsForSystem system;
      modules = [ home ];
    };
}

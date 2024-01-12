{ lib, inputs, ... }:

{
  importAllUsers = import ../users { inherit lib inputs; };

  mkUser = { username, stateVersion, system ? "x86_64-linux", hostname ? null }:
    let
      home = import ../users/${username}/home.nix {
        inherit lib system hostname stateVersion;
      };
    in inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = lib.pkgsForSystem system;
      modules = [ home ];
    };
}

{ inputs, outputs, ... }:

{
  mkUser = { username, stateVersion, system ? "x86_64-linux", hostname ? null }:
    outputs.lib.homeManagerConfiguration {
      pkgs = outputs.lib.pkgsForSystem system;

      extraSpecialArgs = {
        inherit inputs outputs username system hostname stateVersion;
      };

      modules = [
        ../modules/home-manager/system-config-support.nix
        ../users/${username}/home.nix
      ];
    };
}

{ inputs, outputs, ... }:

{
  mkUser = { username, stateVersion, system ? "x86_64-linux", hostname ? null }:
    outputs.lib.homeManagerConfiguration {
      pkgs = outputs.lib.pkgsForSystem system;

      extraSpecialArgs = {
        inherit inputs outputs username system hostname stateVersion;
      };

      modules = [
        ../users/${username}/home.nix

        inputs.sops-nix.homeManagerModules.sops

        (import ../modules/common/nixpkgs.nix { inherit outputs; })

        (import ../modules/home-manager/system-config-support.nix {
          inherit outputs;
        })
      ];
    };
}

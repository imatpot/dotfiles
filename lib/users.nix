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

        outputs.commonModules.nixpkgs
        outputs.homeManagerModules.systemConfigSupport
      ];
    };
}

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nur.url = "github:nix-community/nur";
  };

  outputs = inputs@{ self, ... }:
    let
      linuxSystems = [ "x86_64-linux" "aarch64-linux" ];
      macosSystems = [ "x86_64-darwin" "aarch64-darwin" ];
      lib = inputs.nixpkgs.lib // import ./lib { inherit inputs; };
    in {
      nixosConfigurations = {
        nixos = lib.mkHost {
          system = "x86_64-linux";
          hostname = "nixos";
          stateVersion = "";
        };
      };

      packages = lib.nixosRebuild linuxSystems
        // lib.homeManagerRebuild macosSystems;
    };
}

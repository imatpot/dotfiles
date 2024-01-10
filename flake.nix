{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nur.url = "github:nix-community/nur";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs@{ self, ... }:
    let
      linuxSystems = [ "x86_64-linux" "aarch64-linux" ];
      macosSystems = [ "x86_64-darwin" "aarch64-darwin" ];
      allSystems = linuxSystems ++ macosSystems;
      lib = inputs.nixpkgs.lib // inputs.home-manager.lib // import ./lib { inherit inputs; };

    in {
      nixosConfigurations = {
        nixos = lib.mkHost {
          system = "x86_64-linux";
          hostname = "nixos";
          stateVersion = "23.11";
        };
      };

      homeConfiguration = {
        mladen = lib.homeManagerConfiguration {
          modules = [ ./users/mladen ];
        };
      };

      packages = lib.nixosRebuild linuxSystems
        // lib.homeManagerRebuild macosSystems;

      formatter = lib.withEachSystemPkgs allSystems (pkgs: pkgs.nixfmt);
    };
}

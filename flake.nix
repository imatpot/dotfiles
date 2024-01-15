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

    in rec {
      lib = import ./lib { inherit inputs; };

      nixosConfigurations = import ./hosts { inherit lib inputs; };
      homeConfigurations = import ./users { inherit lib inputs; };

      formatter = lib.forEachSystem allSystems (pkgs: pkgs.nixfmt);
    };
}

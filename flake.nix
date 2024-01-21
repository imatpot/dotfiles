{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nur.url = "github:nix-community/nur";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    vault = {
      url = "git+ssh://git@github.com/imatpot/vault";
      flake = false;
    };
  };

  outputs = inputs:
    let
      linuxSystems = [ "x86_64-linux" "aarch64-linux" ];
      macosSystems = [ "x86_64-darwin" "aarch64-darwin" ];
      allSystems = linuxSystems ++ macosSystems;

      flake = {
        inherit inputs;
        inherit (inputs.self) outputs;
      };

    in rec {
      lib = import ./lib flake;

      nixosConfigurations = import ./hosts flake;
      homeConfigurations = import ./users flake;

      formatter = lib.forEachSystem allSystems (pkgs: pkgs.nixfmt);
    };
}

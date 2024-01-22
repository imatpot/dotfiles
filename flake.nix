{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nur.url = "github:nix-community/nur";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-index-database = {
      url = "github:mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    mac-app-util = {
      url = "github:hraban/mac-app-util";
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

    in rec {
      lib = import ./lib {
        inherit inputs;
        inherit (inputs.self) outputs;
      };

      nixosConfigurations.shinobi = lib.mkHost {
        hostname = "shinobi";
        users = [ "mladen" ];
      };

      nixosConfigurations.adele = lib.mkHost {
        hostname = "adele";
        users = [ "mladen" ];
      };

      homeConfigurations.mladen = lib.mkUser { username = "mladen"; };

      homeConfigurations."mladen@mcdonalds" = lib.mkUser {
        username = "mladen";
        system = "aarch64-darwin";
        hostname = "mcdonalds";
      };

      formatter = lib.forEachSystem allSystems (pkgs: pkgs.nixfmt);
    };
}

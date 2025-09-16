{
  description = "teatpot's Nix-powered dotfiles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nur.url = "github:nix-community/nur";

    vault.url = "git+ssh://git@github.com/imatpot/vault";
    nixvim.url = "github:imatpot/nixvim";
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # mac-app-util = {
    #   url = "github:hraban/mac-app-util";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    minegrub-theme = {
      url = "github:Lxtharia/minegrub-theme";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs: let
    linuxSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    darwinSystems = [
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    systems = linuxSystems ++ darwinSystems;
  in rec {
    lib = import ./lib/lib.nix {
      inherit inputs;
      inherit (inputs.self) outputs;
    };

    nixosConfigurations.shinobi = lib.mkHost {
      system = "x86_64-linux";
      hostname = "shinobi";
      users = ["mladen"];
    };

    nixosConfigurations.atlas = lib.mkHost {
      system = "x86_64-linux";
      hostname = "atlas";
      users = ["mladen"];
    };

    nixosConfigurations.fhnw-syspr = lib.mkHost {
      system = "aarch64-linux";
      hostname = "fhnw-syspr";
      users = ["mladen"];
      isVM = true;
    };

    darwinConfigurations.mcdonalds = lib.mkHost {
      system = "aarch64-darwin";
      hostname = "mcdonalds";
      users = ["mladen"];
    };

    homeConfigurations.mladen = lib.mkUser {username = "mladen";};

    homeConfigurations."mladen@mcdonalds" = lib.mkUser {
      system = "aarch64-darwin";
      hostname = "mcdonalds";
      username = "mladen";
    };

    formatter = lib.forEachSystem systems (
      pkgs:
        pkgs.writeShellScriptBin "alejandra" ''
          exec ${lib.getExe pkgs.alejandra} --quiet "$@"
        ''
    );
  };
}

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nur.url = "github:nix-community/nur";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./configuration.nix ];
      };
    };

    packages.x86_64-linux =
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        nixos-rebuild = subcommand: pkgs.writeScriptBin
          "nixos-rebuild-${subcommand}"
          "sudo nixos-rebuild ${subcommand} --flake ${./.}";
      in
      rec {
        default = switch;

        build = nixos-rebuild "build";
        boot = nixos-rebuild "boot";
        switch = nixos-rebuild "switch";

        repl = nixos-rebuild "repl";
        dry-build = nixos-rebuild "dry-build";
      };
  };
}

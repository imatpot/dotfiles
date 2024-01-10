{ inputs, ... }:

let
  utils = import ./utils.nix { inherit inputs; };
  rebuild = pkgs: genre: subcommand:
    pkgs.writeScriptBin "${genre}-rebuild-${subcommand}"
    "sudo ${genre}-rebuild ${subcommand} --flake ${./.}";

in {
  nixosRebuild = systems:
    utils.forEachSystem systems (pkgs:
      let nixos-rebuild = rebuild pkgs "nixos";
      in rec {
        default = switch;
        build = nixos-rebuild "build";
        boot = nixos-rebuild "boot";
        switch = nixos-rebuild "switch";
      });

  homeManagerRebuild = systems:
    utils.forEachSystem systems (pkgs:
      let home-manager-rebuild = rebuild pkgs "home-manager";
      in rec {
        default = switch;
        build = home-manager-rebuild "build";
        switch = home-manager-rebuild "switch";
      });
}

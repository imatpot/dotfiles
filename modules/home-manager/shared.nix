# Modules shared across NixOS, Darwin, and standalone Home Configurations

{ inputs, outputs, system, hostname, ... }:

outputs.lib.mkFor system hostname {
  common.imports = [
    inputs.sops-nix.homeManagerModules.sops
    inputs.vault.homeModules.default
    inputs.nix-index-database.hmModules.nix-index
    ../nix/nixpkgs.nix
    ./system-config-support.nix
  ];

  systems.darwin.imports = [
    # TODO: Check back later if it compiles again
    # inputs.mac-app-util.homeManagerModules.default
  ];
}

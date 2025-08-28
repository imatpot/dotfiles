# Modules shared across NixOS, Darwin, and standalone Home Configurations
{
  inputs,
  outputs,
  system,
  hostname,
  ...
}:
outputs.lib.mkFor system hostname {
  common.imports = [
    inputs.sops-nix.homeManagerModules.sops
    inputs.vault.homeModules.default
    inputs.nix-index-database.homeModules.nix-index

    "${inputs.self}/modules/nix/nixpkgs.nix"
    "${inputs.self}/lib/modules/home-manager/system-config-support.nix"
  ];

  systems.darwin.imports = [
    # TODO: Check back later if it compiles again
    # inputs.mac-app-util.homeManagerModules.default
  ];
}

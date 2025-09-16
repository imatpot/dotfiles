flake @ {
  inputs,
  outputs,
  ...
}: let
  sharedModules = [
    "${inputs.self}/modules/nix/nix.nix"
    "${inputs.self}/modules/nix/nixpkgs.nix"
    "${inputs.self}/modules/nix/legacy.nix"
    "${inputs.self}/lib/modules/home/system-submodule.nix"
  ];
in rec {
  mkHost = args @ {
    system,
    users ? [],
    stateVersion ? outputs.lib.defaultStateVersionForSystem system,
    isVM ? false,
    ...
  }: let
    args' =
      args
      // {
        # https://nixos.wiki/wiki/Nix_Language_Quirks#Default_values_are_not_bound_in_.40_syntax
        inherit users stateVersion;
      };
  in
    if outputs.lib.isLinux system
    then mkLinux args'
    else if outputs.lib.isDarwin system
    then mkDarwin args'
    else throw "Unsupported system: ${system}";

  mkLinux = args @ {
    hostname,
    system,
    isVM,
    ...
  }:
    outputs.lib.nixosSystem {
      inherit system;
      specialArgs = flake // args;

      modules =
        sharedModules
        ++ [
          "${inputs.self}/modules/nixos/default-config.nix"

          inputs.vault.nixosModules.secrets
          inputs.disko.nixosModules.disko
          inputs.stylix.nixosModules.stylix
          inputs.minegrub-theme.nixosModules.default
          inputs.nix-flatpak.nixosModules.nix-flatpak
        ]
        ++ (
          if isVM
          then
            (outputs.lib.enumeratePaths {
              path = "${inputs.self}/hosts/vms/${hostname}";
            })
          else
            (outputs.lib.enumeratePaths {
              path = "${inputs.self}/hosts/${hostname}";
            })
        );
    };

  mkDarwin = args @ {
    hostname,
    system,
    isVM,
    ...
  }:
    outputs.lib.darwinSystem {
      inherit system;
      specialArgs = flake // args;

      modules =
        sharedModules
        ++ [
          "${inputs.self}/modules/macos/default-config.nix"
        ]
        ++ (
          if isVM
          then [
            "${inputs.self}/hosts/vms/${hostname}/configuration.nix"
          ]
          else [
            "${inputs.self}/hosts/${hostname}/configuration.nix"
          ]
        );
    };
}

flake @ {
  inputs,
  outputs,
  ...
}: let
  sharedModules = [
    ../modules/nix/nix.nix
    ../modules/nix/nixpkgs.nix
    ../modules/nix/legacy.nix
    ../modules/home-manager/system-submodule.nix
  ];
in rec {
  mkHost = args @ {
    system,
    users ? [],
    stateVersion ? outputs.lib.defaultStateVersionForSystem system,
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
    then mkNixos args'
    else if outputs.lib.isDarwin system
    then mkDarwin args'
    else throw "Unsupported system: ${system}";

  mkNixos = args @ {
    hostname,
    system,
    ...
  }:
    outputs.lib.nixosSystem {
      inherit system;
      specialArgs = flake // args;

      modules =
        sharedModules
        ++ [
          ../modules/linux/default-config.nix

          inputs.disko.nixosModules.disko
          inputs.stylix.nixosModules.stylix
          inputs.minegrub-theme.nixosModules.default
        ]
        ++ (outputs.lib.enumeratePaths {
          path = ../hosts/${hostname};
        });
    };

  mkDarwin = args @ {
    hostname,
    system,
    ...
  }:
    outputs.lib.darwinSystem {
      inherit system;
      specialArgs = flake // args;

      modules =
        sharedModules
        ++ [
          ../hosts/${hostname}/configuration.nix
          ../modules/darwin/default-config.nix
        ];
    };
}

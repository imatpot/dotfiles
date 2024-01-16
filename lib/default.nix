# Let's build the flake's lib with the correct dependency tree

{ inputs, ... }:

let
  externalLib =
    inputs.nixpkgs.lib.extend (final: prev: inputs.home-manager.lib);

  utilLib = externalLib.extend (final: prev:
    import ./utils.nix {
      inherit inputs;
      lib = externalLib;
    });

  coreLib = utilLib.extend (final: prev:
    prev.importAndMerge [ ./systems.nix ./pkgs.nix ./secrets.nix ] {
      inherit inputs;
      lib = prev;
    });

  userLib = coreLib.extend (final: prev:
    prev.importAndMerge [ ./users.nix ] {
      inherit inputs;
      lib = prev;
    });

  finalLib = userLib.extend (final: prev:
    prev.importAndMerge [ ./hosts.nix ] {
      inherit inputs;
      lib = prev;
    });

in finalLib

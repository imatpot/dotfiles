# Let's build the flake's lib with the correct dependency tree

{ inputs, outputs, ... }:

let
  external = inputs.nixpkgs.lib.extend (final: prev: inputs.home-manager.lib);

  utils = import ./utils.nix {
    inherit inputs;
    lib = external;
  };

  core = utils.deepMerge [ inputs.nixpkgs.lib inputs.home-manager.lib utils ];

  base = utils.deepMerge [
    core
    (utils.importAndMerge [ ./systems.nix ./pkgs.nix ./secrets.nix ] {
      inherit inputs;
      lib = core;
    })
  ];

  lib = utils.deepMerge [
    base
    (utils.importAndMerge [ ./users.nix ./hosts.nix ] {
      inherit inputs outputs;
    })
  ];

in lib

# Let's build the flake's lib with the correct dependency tree

{ inputs, ... }:

let
  simpleLib = inputs.nixpkgs.lib // inputs.home-manager.lib;

  utils = import ./utils.nix {
    inherit inputs;
    lib = simpleLib;
  };

  systems = import ./systems.nix {
    inherit inputs;
    lib = simpleLib;
  };

  pkgs = import ./pkgs.nix {
    inherit inputs;
    lib = simpleLib;
  };

  coreLib = utils.deepMerge [ simpleLib utils systems pkgs ];

  # Depends on systems.pkgsForSystem
  users = import ./users.nix {
    inherit inputs;
    lib = coreLib;
  };

  userLib = utils.deepMerge [ coreLib users ];

  # Depends on users.mkUser
  hosts = import ./hosts.nix {
    inherit inputs;
    lib = userLib;
  };

  finalLib = utils.deepMerge [ userLib hosts ];

in finalLib

# Let's build the flake's lib with the correct dependency tree

{ inputs, ... }:

let
  primitiveLib = inputs.nixpkgs.lib // inputs.home-manager.lib;

  utils = import ./utils.nix {
    inherit inputs;
    lib = primitiveLib;
  };

  systems = import ./systems.nix {
    inherit inputs;
    lib = primitiveLib;
  };

  coreLib = utils.fuseAttrs [
    inputs.nixpkgs.lib
    inputs.home-manager.lib
    utils
    systems
  ];

  # Depends on systems.pkgsForSystem
  users = import ./users.nix {
    inherit inputs;
    lib = coreLib;
  };

  userLib = utils.fuseAttrs [
    inputs.nixpkgs.lib
    inputs.home-manager.lib
    utils
    systems
    users
  ];

  # Depends on users.mkUser
  hosts = import ./hosts.nix {
    inherit inputs;
    lib = userLib;
  };

in utils.fuseAttrs [
  inputs.nixpkgs.lib
  inputs.home-manager.lib
  utils
  systems
  hosts
  users
]

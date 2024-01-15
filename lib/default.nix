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

  lib' = utils.fuseAttrs [
    inputs.nixpkgs.lib
    inputs.home-manager.lib
    utils
    systems
  ];

  users = import ./users.nix {
    inherit inputs;
    lib = lib';
  };

  lib'' = utils.fuseAttrs [
    inputs.nixpkgs.lib
    inputs.home-manager.lib
    utils
    systems
    users
  ];

  hosts = import ./hosts.nix {
    inherit inputs;
    lib = lib'';
  };

in utils.fuseAttrs [
  inputs.nixpkgs.lib
  inputs.home-manager.lib
  utils
  systems
  hosts
  users
]

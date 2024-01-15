{ lib, inputs, ... }:

final: prev: {
  nur = import inputs.nur {
    pkgs = lib.pkgsForSystem prev.system;
    nurpkgs = import inputs.nixpkgs {
      system = final.system;
      config = lib.nixpkgsDefaultConfig;
    };
  };
}

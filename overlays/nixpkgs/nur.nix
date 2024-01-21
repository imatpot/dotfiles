{ inputs, outputs, ... }:

_: prev: {
  nur = import inputs.nur {
    pkgs = prev;
    nurpkgs = import inputs.nixpkgs {
      system = prev.system;
      config = outputs.lib.nixpkgsDefaultConfig;
    };
  };
}

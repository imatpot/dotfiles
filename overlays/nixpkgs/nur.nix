{ inputs, outputs, ... }:

{
  nur = final: prev: {
    nur = import inputs.nur {
      pkgs = outputs.lib.pkgsForSystem prev.system;
      nurpkgs = import inputs.nixpkgs {
        system = final.system;
        config = outputs.lib.nixpkgsDefaultConfig;
      };
    };
  };
}

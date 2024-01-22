{ inputs, outputs, ... }:

{
  defaultSystem = "x86_64-linux";
  defaultStateVersion = "24.05";

  defaultNixpkgsConfig = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  defaultNixpkgsOverlays = [
    (_: prev: {
      unstable = import inputs.nixpkgs-unstable {
        system = prev.system;
        config = outputs.lib.defaultNixpkgsConfig;
      };
      nur = import inputs.nur {
        pkgs = prev;
        nurpkgs = import inputs.nixpkgs {
          system = prev.system;
          config = outputs.lib.defaultNixpkgsConfig;
        };
      };
    })
  ];
}

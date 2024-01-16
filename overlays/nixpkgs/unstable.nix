{ inputs, outputs, ... }:

{
  unstable = _: prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = prev.system;
      config = outputs.lib.nixpkgsDefaultConfig;
    };
  };
}

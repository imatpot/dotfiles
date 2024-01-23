{ inputs, outputs, ... }:

{
  defaultStateVersion = "24.05";

  # Nix-Darwin is cringe and has integer state versions
  # https://daiderd.com/nix-darwin/manual/index.html#opt-system.stateVersion
  defaultDarwinStateVersion = 4;

  defaultNixpkgsConfig = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  defaultNixpkgsOverlays = [
    (_: prev: {
      master = import inputs.nixpkgs-master {
        inherit (prev) system;
        config = outputs.lib.defaultNixpkgsConfig;
      };
      unstable = import inputs.nixpkgs-unstable {
        inherit (prev) system;
        config = outputs.lib.defaultNixpkgsConfig;
      };
      nur = import inputs.nur {
        pkgs = prev;
        nurpkgs = import inputs.nixpkgs {
          inherit (prev) system;
          config = outputs.lib.defaultNixpkgsConfig;
        };
      };
    })
  ];
}

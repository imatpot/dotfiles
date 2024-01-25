{ inputs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };

    overlays = [
      (_: prev: {
        master = import inputs.nixpkgs-master {
          inherit (prev) system config overlays;
        };
      })

      (_: prev: {
        unstable = import inputs.nixpkgs-unstable {
          inherit (prev) system config overlays;
        };
      })

      (_: prev: { nur = import inputs.nur { pkgs = prev; }; })
    ];
  };
}

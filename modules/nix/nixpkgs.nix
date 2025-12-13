{inputs, ...}: {
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

      (_: prev: {
        nur = import inputs.nur {
          pkgs = prev;
        };
      })

      (_: prev: {
        nixvim = inputs.nixvim.packages.${prev.system}.nvim;
      })

      (_: prev: {
        nix-alien = inputs.nix-alien.packages.${prev.system}.default;
      })

      (_: prev: {
        zen-browser = inputs.zen-browser.packages.${prev.system}.default;
      })
    ];
  };
}

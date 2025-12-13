{inputs, ...}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };

    overlays = [
      (_: prev: {
        master = import inputs.nixpkgs-master {
          inherit (prev) config;
          system = prev.stdenv.hostPlatform.system;
        };
      })

      (_: prev: {
        unstable = import inputs.nixpkgs-unstable {
          inherit (prev) config;
          system = prev.stdenv.hostPlatform.system;
        };
      })

      (_: prev: {
        nur = import inputs.nur {
          pkgs = prev;
        };
      })

      # https://github.com/NixOS/nixpkgs/issues/437992#issuecomment-3380880457
      (_: prev: {
        inherit
          (import inputs.nixpkgs-stremio {
            inherit (prev) config;
            system = prev.stdenv.hostPlatform.system;
          })
          stremio
          ;
      })

      (_: prev: {
        nixvim = inputs.nixvim.packages.${prev.stdenv.hostPlatform.system}.nvim;
      })

      (_: prev: {
        nix-alien = inputs.nix-alien.packages.${prev.stdenv.hostPlatform.system}.default;
      })

      (_: prev: {
        zen-browser = inputs.zen-browser.packages.${prev.stdenv.hostPlatform.system}.default;
      })
    ];
  };
}

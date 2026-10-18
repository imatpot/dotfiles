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
        stable = import inputs.nixpkgs-stable {
          inherit (prev) config;
          system = prev.stdenv.hostPlatform.system;
        };
      })

      (_: prev: {
        nur = import inputs.nur {
          pkgs = prev;
        };
      })

      (_: prev: {
        ntrviewer-hr =
          (import inputs.nixpkgs-ntrviewer-hr {
            # inherit (prev) config;
            system = prev.stdenv.hostPlatform.system;
          }).ntrviewer-hr;
      })

      (_: prev: {
        nixvim = inputs.nixvim.packages.${prev.stdenv.hostPlatform.system}.nvim;
      })

      (_: prev:
        prev.lib.optionalAttrs prev.stdenv.hostPlatform.isLinux {
          nix-alien = inputs.nix-alien.packages.${prev.stdenv.hostPlatform.system}.default;
        })

      (_: prev: {
        zen-browser = inputs.zen-browser.packages.${prev.stdenv.hostPlatform.system}.default;
      })

      inputs.niri.overlays.niri
      # https://github.com/sodiboo/niri-flake/issues/1851
      (final: prev: {
        libdisplay-info_0_2 = prev.libdisplay-info.overrideAttrs (old: {
          version = "0.2.0";
          src = prev.fetchFromGitLab {
            domain = "gitlab.freedesktop.org";
            owner = "emersion";
            repo = "libdisplay-info";
            tag = "0.2.0";
            hash = "sha256-6xmWBrPHghjok43eIDGeshpUEQTuwWLXNHg7CnBUt3Q=";
          };
        });
      })
      
      (_: prev: {
        noctalia-shell = inputs.noctalia-shell.packages.${prev.stdenv.hostPlatform.system}.default;
      })
      
      inputs.llm-agents.overlays.shared-nixpkgs
    ];
  };
}

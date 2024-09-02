{ outputs, pkgs, ... }:

{
  home = {
    packages = with pkgs.unstable; [
      # JavaScript
      nodejs
      deno

      # Rust
      # cargo
      # rustc

      # Mobile
      android-tools

      # dart
      # TODO: Flutter is broken on unstable, using less stable master until fixed
      # Flutter should apparently be run with Rosetta on aaarch64-darwin
      # https://github.com/NixOS/nixpkgs/commit/03ae92a17d0f9683a1da5eaee77b0497a0d7ba66
      # (if pkgs.system == "aarch64-darwin" then
      #   (outputs.lib.pkgsForSystem "x86_64-darwin").master.flutter
      # else
      #   pkgs.master.flutter)

      # C#
      (with dotnetCorePackages; combinePackages [ sdk_6_0 sdk_7_0 sdk_8_0 ])

      # Python
      (python3.withPackages (pyPkgs: with pyPkgs; [ pip ipykernel ]))

      # (python3.withPackages (pp:
      #   with pp;
      #   [
      #     pip
      #     black
      #     numpy
      #     pandas
      #     jupyter
      #     tabula-py
      #     camelot
      #     pyppeteer
      #     scikit-learn
      #     seaborn
      #   ] ++ (with pandas.optional-dependencies; plot ++ excel ++ html)))

      # Haskell
      # ghc
      # cabal-install

      # Java
      maven

      # Other programming languages
      # vlang
      # nim
      # zig

      # DevOps
      flux
      kubectl
      postgresql

      # Diagrams
      plantuml
      graphviz

      # Networking
      nmap

      # Misc
      watchexec
      # piper-tts
    ];

    shellAliases = rec {
      python = "python3";
      py = python;

      venv = "source .venv/bin/activate";
      new-venv = "python3 -m venv .venv";
    };

    sessionVariables = { TLDR_AUTO_UPDATE_DISABLED = "1"; };
  };

  programs = {
    java = {
      enable = true;
      package = pkgs.unstable.jdk21;
    };

    zsh.initExtra = ''
      # Add FVM to PATH
      export PATH="$HOME/.fvm_flutter/bin:$PATH"
    '';
  };
}

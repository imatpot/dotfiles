{ outputs, pkgs, ... }:

{
  home = {
    packages = with pkgs.unstable; [
      # JavaScript
      nodejs
      yarn
      deno

      # Rust
      cargo
      rustc

      # Mobile
      android-tools

      # TODO: Flutter is broken on unstable, using less stable master until fixed
      # Flutter should apparently be run with Rosetta on aaarch64-darwin
      # https://github.com/NixOS/nixpkgs/commit/03ae92a17d0f9683a1da5eaee77b0497a0d7ba66
      (if pkgs.system == "aarch64-darwin" then
        (outputs.lib.pkgsForSystem "x86_64-darwin").master.flutter
      else
        pkgs.master.flutter)

      # C#
      (with dotnetCorePackages; combinePackages [ sdk_6_0 sdk_7_0 sdk_8_0 ])

      # Python
      python3

      # Haskell
      ghc
      cabal-install

      # Other programming languages
      vlang
      nim
      zig

      # DevOps
      flux
      kubectl

      # Diagrams
      plantuml
      graphviz

      # Networking
      nmap

      # Misc
      bat
      exa
      toybox
      tldr
      watchexec
    ];

    shellAliases = rec {
      cat = "bat";
      ll = "exa -aFl --time-style long-iso";
      python = "python3";
      py = python;
      mkcd = "fn() { mkdir -p $1 && cd $1; }; fn";
    };
  };

  programs.java = {
    enable = true;
    package = pkgs.unstable.jdk21;
  };
}

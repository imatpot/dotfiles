{ config, pkgs, lib, ... }:

let
  gui = config.services.xserver.enable;

in
  with lib; {
    imports = [
      ./base.nix
      ../modules/docker.nix
    ];

    programs.adb.enable = true;

    # Unstables are more up-to-date
    environment.systemPackages =
      with pkgs.unstable; [
        nodejs
        python39

        rustup
        gcc

        flutter

        # Yes, it's big.
        # But it works offline, which I need on the go sometimes.
        texlive.combined.scheme-full

        rnix-lsp
      ] ++ (
        if gui then
          [
            vscode
            android-studio
          ] else []
      );
  }

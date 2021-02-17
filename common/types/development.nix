{ config, pkgs, ... }:

{
  imports = [
    ./base.nix
    ../modules/docker.nix
  ];

  programs.adb.enable = true;

  # Unstables are more up-to-date
  environment.systemPackages =
    with pkgs.unstable;

    let
      common = [
        nodejs
        python39

        rustup
        gcc

        flutter

        # Yes, it's big.
        # But it works offline, which I need on the go sometimes.
        texlive.combined.scheme-full

        rnix-lsp
      ];
      xorg = [
        vscode
        android-studio
      ];

    in
      common ++ (
        if config.services.xserver.enable
        then xorg
        else []
      );
}

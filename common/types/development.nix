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

        flutter
        texlive.combined.scheme-basic

        rnix-lsp
      ];
      xorg = [
        vscode
        android-studio
      ];

    in common ++ (
      if config.services.xserver.enable
        then xorg
        else []
    );
}

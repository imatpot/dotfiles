{ config, pkgs, ... }:

{
  imports = [
    ./base.nix
    ../modules/docker.nix
  ];

  programs.adb.enable = true;

  # Unstables are more up-to-date
  environment.systemPackages =
    with pkgs;

    let
      common = [
        unstable.nodejs
        unstable.python39

        unstable.flutter
        unstable.texlive.combined.scheme-basic
      ];
      xorg = [
        unstable.vscode
        unstable.android-studio
      ];

    in common ++ (
      if config.services.xserver.enable
        then xorg
        else []
    );
}

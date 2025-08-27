{
  config,
  pkgs,
  ...
}: let
  gui = config.services.xserver.enable;
in {
  imports = [
    ./base.nix
    ../modules/docker.nix
  ];

  programs.adb.enable = true;

  services.lorri = {
    enable = true;
    package = pkgs.unstable.lorri;
  };

  environment.systemPackages = with pkgs;
    [
      unstable.rnix-lsp
      unstable.nixpkgs-fmt
    ]
    ++ (
      if gui
      then [unstable.vscode]
      else []
    );
}

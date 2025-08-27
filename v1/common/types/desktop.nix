{pkgs, ...}: {
  imports = [
    ./development.nix

    ../printing.nix
    ../sound.nix

    ../modules/xserver.nix
  ];

  environment.systemPackages = with pkgs; [
    alacritty
    firefox-bin
    ungoogled-chromium
  ];
}

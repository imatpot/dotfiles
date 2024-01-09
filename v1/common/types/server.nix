{ pkgs, ... }:

{
  imports = [
    ./base.nix
    ../modules/docker.nix
  ];

  environment.systemPackages = with pkgs; [
    inotify-tools
  ];
}

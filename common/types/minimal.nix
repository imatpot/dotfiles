{ config, pkgs, ... }:

let
  unstable-tar = https://github.com/nixos/nixpkgs/tarball/nixos-unstable;
  nur-tar = https://github.com/nix-community/NUR/tarball/master;

in {
  nixpkgs.config = {
    allowUnfree = true;

    packageOverrides = pkgs: {
      # Add unstable channel
      unstable = import (builtins.fetchTarball unstable-tar) { inherit (config.nixpkgs) config; };

      # Add Nix User Repository
      nur = import (builtins.fetchTarball nur-tar) { inherit pkgs; };
    };
  };

  imports = [
    ../boot.nix
    ../locale.nix
    ../wheel-nopasswd.nix
    ../printing.nix
    ../sound.nix
  ];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Do not install optional default packages (e.g. perl)
  environment.defaultPackages = [];

  programs.ssh.startAgent = true;
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };

  programs.gnupg.agent.enable = true;

  console.font = "Lat2-Terminus16";

  # Some (personal) necessities
  environment.systemPackages = with pkgs; [
    wget

    vim
    nano
    git

    # Some terminal-based system maintenance
    ncdu
    gotop

    neofetch # NixOS flex
  ];
}

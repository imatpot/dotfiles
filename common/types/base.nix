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
    ./minimal.nix
  ];

  programs.ssh.startAgent = true;
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
  };

  programs.gnupg.agent.enable = true;

  # Some (personal) necessities
  environment.systemPackages = with pkgs; [
    ncdu
    gotop
    neofetch # NixOS flex
  ];
}

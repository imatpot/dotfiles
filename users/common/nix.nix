{ pkgs, ... }:

{
  home.packages = with pkgs; [
    comma
    nom
    nil
    # nixd
    nixfmt
    # alejandra
    deadnix
    nix-index
  ];
}

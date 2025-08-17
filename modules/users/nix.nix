{ pkgs, ... }:

{
  programs.nix-index-database.comma.enable = true;
  home.shellAliases.nix-gc = "nix-collect-garbage";

  home = {
    packages = with pkgs; [
      nix-output-monitor
      nixd
      nil
      nixfmt-classic
      deadnix
      statix
      nix-tree
      alejandra
    ];
  };
}

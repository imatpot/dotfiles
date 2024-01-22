{ pkgs, ... }:

{
  programs.nix-index-database.comma.enable = true;

  home = {
    packages = with pkgs; [
      nom
      nil
      # nixd
      nixfmt
      # alejandra
      deadnix
    ];

    shellAliases = {
      nix-gc = "nix-collect-garbage";
      shell = "nix shell";
    };
  };
}

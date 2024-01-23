{ pkgs, ... }:

{
  programs.nix-index-database.comma.enable = true;

  home = {
    packages = with pkgs; [
      nix-output-monitor
      nil
      # nixd
      nixfmt
      # alejandra
      deadnix
      statix
    ];

    shellAliases = {
      nix-gc = "nix-collect-garbage";
      shell = "nix shell";
      develop = "nix develop";
    };
  };
}

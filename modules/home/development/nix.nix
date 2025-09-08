{
  outputs,
  config,
  pkgs,
  ...
}:
outputs.lib.mkConfigModule config true "dev.nix"
{
  programs.nix-index-database.comma.enable = true;
  home.shellAliases.nix-gc = "nix-collect-garbage";

  home = {
    packages = with pkgs; [
      nix-output-monitor
      nixd
      nil
      deadnix
      statix
      nix-tree
      alejandra
      nixpkgs-review
      nixfmt
    ];
  };
}

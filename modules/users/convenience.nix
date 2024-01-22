{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      bat
      eza
      tldr
      toybox
      jq
    ];

    shellAliases = {
      mkcd = "fn() { mkdir -p $1 && cd $1; }; fn";
      ls = "exa";
      ll = "exa -aFl --time-style long-iso";
      cat = "bat";
    };
  };
}

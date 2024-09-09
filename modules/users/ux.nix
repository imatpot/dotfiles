{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [ bat eza tldr jq ];

    shellAliases = {
      mkcd = "fn() { mkdir -p $1 && cd $1; }; fn";
      ls = "eza";
      ll = "eza --all --classify --long --total-size --time-style long-iso";
      cat = "bat";
    };

    sessionVariables = { TLDR_AUTO_UPDATE_DISABLED = "1"; };
  };
}

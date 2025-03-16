{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [ bat eza tldr jq ];

    shellAliases = {
      mkcd = "fn() { mkdir -p $1 && cd $1; }; fn";
      ls = "eza";
      ll = "eza --all --classify --long --time-style long-iso";
      lll = "ll --total-size";
      cat = "bat";
    };

    sessionVariables = { TLDR_AUTO_UPDATE_DISABLED = "1"; };
  };
}

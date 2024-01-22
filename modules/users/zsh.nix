{ ... }:

{
  programs.zsh = {
    enable = true;

    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    antidote = {
      enable = true;
      useFriendlyNames = true;
      plugins = [
        "hlissner/zsh-autopair"
        "zsh-users/zsh-history-substring-search"
        "z-shell/zsh-diff-so-fancy"
      ];
    };
  };
}

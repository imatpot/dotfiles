{ outputs, ... }:

{
  home.shellAliases = {
    develop = outputs.lib.mkForce "nix develop --command zsh";
  };

  programs.zsh = {
    enable = true;

    enableAutosuggestions = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    antidote = {
      enable = true;
      useFriendlyNames = true;
      plugins =
        [ "hlissner/zsh-autopair" "z-shell/zsh-diff-so-fancy" "rupa/z" ];
    };
  };
}

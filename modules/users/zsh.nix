{ outputs, ... }:

{
  # Forces Nix-Darwin to set up necessary hooks
  macos.programs.zsh.enable = true;

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
        [ "hlissner/zsh-autopair" "z-shell/zsh-diff-so-fancy" "agkozak/zsh-z" ];
    };

    initExtra = ''
      setopt nonomatch

      # Fix issues after macOS updates
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';
  };
}

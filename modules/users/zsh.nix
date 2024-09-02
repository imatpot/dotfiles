{ outputs, ... }:

{
  # Forces Nix-Darwin to set up necessary hooks
  macos.programs.zsh.enable = true;

  home.shellAliases = {
    develop = outputs.lib.mkForce "nix develop --command zsh";
  };

  programs.zoxide.enable = true;

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    antidote = {
      enable = true;
      useFriendlyNames = true;
      plugins = [ "hlissner/zsh-autopair" "z-shell/zsh-diff-so-fancy" ];
    };

    initExtra = ''
      setopt nonomatch

      # Fix issues after macOS updates
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        source '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi

      zh() {
        ZHERE_PATH="$(zoxide query "$(pwd)" "$@")"

        if [ -z "$ZHERE_PATH" ]; then
          return 1
        fi

        cd "$ZHERE_PATH"
      }

      zcode() {
        ZCODE_PATH="$(zoxide query "$@")"

        if [ -z "$ZCODE_PATH" ]; then
          return 1
        fi

        code "$ZCODE_PATH"
      }

      zhcode() {
        ZHCODE_PATH="$(zoxide query "$(pwd)" "$@")"

        if [ -z "$ZHCODE_PATH" ]; then
          return 1
        fi

        code "$ZHCODE_PATH"
      }
    '';
  };
}

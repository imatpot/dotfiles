{ outputs, config, pkgs, username, ... }:

{
  options = {
    modules.users.zsh.enable = outputs.lib.mkEnableOption "Enable ZSH";
  };

  config = outputs.lib.mkIf config.modules.users.zsh.enable {

    # Forces Nix-Darwin to set up necessary hooks
    macos.programs.zsh.enable = true;

    nixos = {
      programs.zsh.enable = true;
      users.users.${username}.shell = pkgs.zsh;
    };

    home.shellAliases = {
      develop = outputs.lib.mkForce "nix develop --command zsh";
      shell = outputs.lib.mkForce "nix shell --command zsh";
    };

    programs.zoxide.enable = true;

    programs.zsh = {
      enable = true;
      package = pkgs.zsh;

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

        eval "$(ssh-agent -s)" &> /dev/null
      '';
    };
  };
}

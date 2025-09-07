{
  outputs,
  config,
  pkgs,
  username,
  system,
  ...
}:
outputs.lib.mkConfigModule config true "zsh" {
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
    defaultKeymap = "emacs";

    antidote = {
      enable = true;
      useFriendlyNames = true;
      plugins = [
        "hlissner/zsh-autopair"
        "z-shell/zsh-diff-so-fancy"
      ];
    };

    initContent = let
      nixvimPath = "${config.home.homeDirectory}/${
        if outputs.lib.isDarwin system
        then "Developer"
        else "Development"
      }/life";
    in ''
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

      znvim() {
        ZNVIM_PATH="$(zoxide query "$@")"

        if [ -z "$ZNVIM_PATH" ]; then
          return 1
        fi

        code "$ZNVIM_PATH"
      }

      zhnvim() {
        ZHNVIM_PATH="$(zoxide query "$(pwd)" "$@")"

        if [ -z "$ZHNVIM_PATH" ]; then
          return 1
        fi

        code "$ZHNVIM_PATH"
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

      zcursor() {
        ZCURSOR_PATH="$(zoxide query "$@")"

        if [ -z "$ZCURSOR_PATH" ]; then
          return 1
        fi

        cursor "$ZCURSOR_PATH"
      }

      zhcursor() {
        ZHCURSOR_PATH="$(zoxide query "$(pwd)" "$@")"

        if [ -z "$ZHCURSOR_PATH" ]; then
          return 1
        fi

        cursor "$ZHCURSOR_PATH"
      }

      zhx() {
        ZHX_PATH="$(zoxide query "$(pwd)" "$@")"

        if [ -z "$ZHX_PATH" ]; then
          return 1
        fi

        cd "$ZHX_PATH"
        hx
      }

      zhhx() {
        ZHHX_PATH="$(zoxide query "$(pwd)" "$@")"

        if [ -z "$ZHHX_PATH" ]; then
          return 1
        fi

        cd "$ZHHX_PATH"
        hx
      }

      alias nixvim="nix run path:${nixvimPath}/nixvim --"
      alias nv="nixvim"

      znixvim() {
        ZNIXVIM_PATH="$(zoxide query "$@")"

        if [ -z "$ZNIXVIM_PATH" ]; then
          return 1
        fi

        cd "$ZNIXVIM_PATH"
        nixvim
      }

      zhnixvim() {
        ZHNIXVIM_PATH="$(zoxide query "$(pwd)" "$@")"

        if [ -z "$ZHNIXVIM_PATH" ]; then
          return 1
        fi

        cd "$ZHNIXVIM_PATH"
        nixvim
      }

      znv() {
        znixvim "$@"
      }

      zhnv() {
        zhnixvim "$(pwd)" "$@"
      }

      eval "$(ssh-agent -s)" &> /dev/null

      # TODO: put this somewhere else but make sure it's after the ssh-agent is started
      ssh-add ~/.ssh/aegis &> /dev/null
      ssh-add ~/.ssh/mladen.brankovic.at.golog.ch &> /dev/null
      ssh-add ~/.ssh/mladen.brankovic.at.students.fhnw.ch &> /dev/null
    '';
  };
}

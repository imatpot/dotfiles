{
  outputs,
  pkgs,
  config,
  ...
}:

let
  git-hide = "!${git-hide-src}/bin/git-hide";
  git-hide-src = pkgs.writeShellApplication {
    name = "git-hide";
    text = builtins.readFile ./git-hide.bash;
    runtimeInputs = with pkgs; [
      git
      gawk
      gnugrep
      coreutils
    ];
  };
in

outputs.lib.mkConfigModule config true "git" {
  programs = {
    git = {
      enable = true;

      settings = {
        user = {
          email = outputs.lib.mkOptionDefault (throw "programs.git.userEmail is not set");
          name = outputs.lib.mkOptionDefault (throw "programs.git.userName is not set");
        };

        core.excludesFile = config.home.homeDirectory + "/.config/git/ignore";
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        pull.rebase = true;
        merge.conflictStyle = "zdiff3";

        alias = rec {
          alias = "config --get-regexp alias";
          aliases = alias;
          alii = alias;

          count = "rev-list --all --count HEAD";

          quick = "!fn() { git add -A && git commit --allow-empty -m \"$*\" && git push; }; fn";
          again = "!fn() { git add -A && git commit --amend --no-edit --gpg-sign; }; fn";
          repush = "!git pull --rebase && git push";

          undo = "reset --soft HEAD~1";
          unstage = "reset --";
          drop = "!git reset --hard && git clean -df";

          recent = "log -3";
          latest = "log -1";
          last = latest;

          graph = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";

          pull-all = "!fn() { find . -type d -maxdepth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull ';'; }; fn";
          delete-all-branches = "!fn() { git checkout main; git branch | grep -v 'main' | xargs git branch -D; }; fn";

          purge = "!fn() { git delete-all-branches; git fetch --prune; git reset --hard origin/main; git clean -df; }; fn";

          hidden = "${git-hide} list";
          hide = "${git-hide} hide";
          unhide = "${git-hide} unhide";
          unhide-all = "${git-hide} unhide-all";
          stash-hidden = "${git-hide} stash";
          unstash-hidden = "${git-hide} unstash";
        };
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;

      options = {
        syntax-theme = "Visual Studio Dark+";
        line-numbers = true;

        side-by-side = true;
        # line-numbers-left-format="";
        # line-numbers-right-format="│";
      };
    };
  };

  home = {
    packages = with pkgs; [
      gitui
      git-hide-src
    ];
  };
}

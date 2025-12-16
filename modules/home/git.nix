{
  outputs,
  pkgs,
  config,
  system,
  ...
}:
outputs.lib.mkConfigModule config true "git"
{
  programs = {
    git = {
      enable = true;

      settings = {
        user = {
          email = outputs.lib.mkOptionDefault (throw "programs.git.userEmail is not set");
          name = outputs.lib.mkOptionDefault (throw "programs.git.userName is not set");
        };

        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        pull.rebase = true;

        alias = rec {
          alias = "config --get-regexp alias";
          aliases = alias;
          alii = alias;

          count = "rev-list --all --count HEAD";

          quick = "!fn() { git add -A && git commit --allow-empty -m \"$*\" && git push; }; fn";
          again = "!fn() { git add -A && git commit --amend --no-edit --gpg-sign; }; fn";

          unstage = "reset --";
          discard = "!git reset --hard && git clean -df";

          recent = "log -3";
          latest = "log -1";
          last = latest;

          graph = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";

          pull-all = "!fn() { find . -type d -maxdepth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull ';'; }; fn";
          delete-all-branches = "!fn() { git checkout main; git branch | grep -v 'main' | xargs git branch -D; }; fn";

          purge = "!fn() { git delete-all-branches; git fetch --prune; git reset --hard origin/main; git clean -df; }; fn";
        };
      };
    };

    diff-so-fancy = {
      enable = true;
      enableGitIntegration = true;
    };
  };

  home = {
    packages = with pkgs; if outputs.lib.isDarwin system then [
      stable.gitui # https://github.com/NixOS/nixpkgs/issues/450861
    ] else [
      gitui
    ];
  };
}

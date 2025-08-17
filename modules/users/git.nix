{ outputs, ... }:

{
  programs.git = {
    enable = true;

    diff-so-fancy.enable = true;

    userEmail = outputs.lib.mkDefault (throw "programs.git.userEmail is not set");
    userName = outputs.lib.mkDefault (throw "programs.git.userName is not set");

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };

    aliases = rec {
      alias = "config --get-regexp alias";
      aliases = alias;
      alii = alias;

      quick = "!fn() { git add -A && git commit --allow-empty -m \"$*\" && git push; }; fn";
      again = "!fn() { git add -A && git commit --amend --no-edit --gpg-sign; }; fn";

      unstage = "reset --";
      discard = "!git reset --hard && git clean -df";

      recent = "log -3";
      latest = "log -1";
      last = latest;

      graph =
        "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";

      pull-all =
        "!fn() { find . -type d -maxdepth 1 -exec git --git-dir={}/.git --work-tree=$PWD/{} pull ';'; }; fn";
      delete-all-branches =
        "!fn() { git checkout main; git branch | grep -v 'main' | xargs git branch -D; }; fn";

      purge =
        "!fn() { git delete-all-branches; git fetch --prune; git reset --hard origin/main; git clean -df; }; fn";
    };
  };
}
